---
name: matlab-evaluation
description: Use this when running, testing, or evaluating Matlab .m scripts on this machine — locating the Matlab binary, setting up toolbox paths for non-interactive sessions, and invoking batch evaluation. Activate for Matlab test runs, tutorial verification in code/, or iePublish HTML generation.
---

# Matlab Evaluation Workflow

## Finding Matlab

- Matlab is not on `$PATH` on this machine. Never assume `matlab` resolves in a shell.
- Installed versions live in `/Applications` as `MATLAB_R20XXx.app` bundles; the executable is `bin/matlab` inside the bundle.
- List installed versions rather than hardcoding a version number — new releases get added over time:

```bash
ls /Applications | rg -i '^MATLAB_R'
```

- Prefer the newest installed release unless the user specifies otherwise or the newest one fails for a version-specific reason.

## Running non-interactively

- Use `-batch`, not `-r`, for evaluation. `-batch` runs headless (no splash, no desktop), still processes Matlab's normal startup files, exits automatically when the statement finishes, and — critically — returns a non-zero exit code and prints the error to stderr if the statement throws. `-r` requires an explicit `exit`/`quit` call and manual `try/catch` to avoid hanging or masking failures.

```bash
/Applications/MATLAB_R2026a.app/bin/matlab -batch "run('code/t_mri01MR.m')"
echo "exit: $?"
```

- Always check `$?` after the call — Matlab does not reliably signal failure through terminal text alone.
- Assume anything unfamiliar could hang: scripts with `pause`, `input`, `keyboard`, or `waitfor` will block a batch session with no one to answer the prompt. Run first attempts with a bash timeout wrapper.

## Toolbox Path Management

### Common Toolbox Locations
- **isetcam**: `~/Documents/MATLAB/isetcam` (contains essential utilities like iePublish)
- **teachmri**: `~/Documents/MATLAB/teach/teachmri` (contains teaching-related utilities)
- **vistasoft**: `~/Documents/MATLAB/vistasoft` (for visual field mapping and diffusion MRI)
- **isetbio**: `~/Documents/MATLAB/isetbio` (for biological image processing)

### Path Setup in Batch Mode
Project toolboxes are not automatically added in non-interactive sessions due to skipped startup prompts:

```matlab
% This branch is skipped in non-interactive sessions
if usejava('desktop')
    % Interactive path setup here
end
```

### Diagnostic Commands
Verify toolbox availability before execution:
```matlab
exist('functionName') % Returns 2 for .m files
which functionName    % Shows path resolution
```

### Error Pattern Recognition
- `Unrecognized function or variable` → Missing toolbox path
- `Undefined function` → Version compatibility issue
- `Operation terminated by user during` → Blocking call (pause/input) without timeout

### Path Setup Example
```bash
/Applications/MATLAB_R2026a.app/bin/matlab -batch "\
addpath(genpath('~/Documents/MATLAB/isetcam')); \
addpath(genpath('~/Documents/MATLAB/teach/teachmri/utility')); \
iePublish('code/t_mri01MR.m')"
```

### Important Notes
- Add only required toolboxes to avoid conflicts between projects
- Check header comments or grep files for non-built-in function calls
- Prefer specific toolbox paths over wholesale `~/Documents/MATLAB` addition

## Working directory

- `-batch` inherits the shell's current working directory as Matlab's `pwd`; it does not `cd` into the repo or the script's folder automatically.
- Some tutorials, and `iePublish` itself, resolve relative paths and write output relative to `pwd`. Launch from — or explicitly `cd` to — whichever directory the script assumes (usually the repo root for this project).

## Typical flow for this repo's tutorials (`code/*.m`)

1. Identify which toolbox, if any, the tutorial needs.
2. Confirm it runs cleanly:

```bash
/Applications/MATLAB_R2026a.app/bin/matlab -batch "addpath(genpath('~/Documents/MATLAB/<toolbox>')); run('code/<tutorial>.m')"
```

3. Once it runs cleanly, publish it to a self-contained HTML file with `iePublish` (from isetcam):

```bash
/Applications/MATLAB_R2026a.app/bin/matlab -batch "addpath(genpath('~/Documents/MATLAB/isetcam')); iePublish('code/<tutorial>.m')"
```

4. `iePublish` writes the HTML next to the source `.m` file. Confirm the output landed where expected and that figures embedded correctly before treating the conversion as done.

## Best Practices & Warnings

1. **MATLAB Path Resolution**
   - Never assume `matlab` is in `$PATH` - always use full executable path
   - List installed versions: `ls /Applications | rg -i '^MATLAB_R'`

2. **Execution Mode**
   - Prefer `-batch` over `-r` for better error handling
   - Always check exit status: `echo "exit: $?"`

3. **Toolbox Management**
   - Add only required toolboxes to avoid conflicts
   - Never use wholesale `addpath(genpath('~/Documents/MATLAB'))`
   - Verify paths with diagnostic commands

4. **Blocking Calls**
   - Use timeout wrappers for scripts with `pause`, `input`, or `waitfor`
   ```bash
   timeout 30s matlab -batch "command" # 30-second timeout
   ```

5. **Working Directory**
   - `-batch` inherits shell's working directory
   - Use explicit `cd` in MATLAB or shell when needed
