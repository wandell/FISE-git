---
name: chapter-podcasts
description: Guidelines and workflows for creating, compressing, placing, and embedding chapter audio overviews and podcasts (such as NotebookLM discussions) in FISE Quarto chapters.
---

# Chapter podcasts and audio overviews

This skill governs the addition of audio overviews, chapter podcasts, and spoken discussions (such as two-person dialogues generated with NotebookLM) into FISE chapters.

---

## 1. Directory structure and naming conventions

- All podcast audio files live in `chapters/podcasts/`.
- Name files descriptively using CamelCase with underscores or snake_case matching the chapter topic (for example, `Why_Movement_and_Physics_Define_Vision.m4a`).
- Path references in chapter `.qmd` files (which live inside `chapters/`) are relative:
  ```markdown
  podcasts/<filename>.m4a
  ```

---

## 2. Audio compression standards

Podcasts exported from AI tools like NotebookLM are generated as **256 kbps stereo** files, producing 40–80 MB files for a 20–30 minute episode. Because dialogue is spoken voice:

1. **Mono channel (`-ac 1`):** Spoken conversation does not require stereo separation. Converting to mono reduces file size by ~50% immediately with zero perceptual loss.
2. **Target Bitrate (`48 kbps` AAC):** 48 kbps mono AAC provides pristine voice clarity while reducing file size by **over 80%** (typically ~8 MB for a 22-minute episode). For maximum fidelity, **64 kbps** (~10.5 MB) can also be used.
3. **Container format (`.m4a`):** Use MPEG-4 Audio (`.m4a` / AAC), natively supported across all modern desktop and mobile browsers.

### Compression tool hierarchy

#### Option A: `ffmpeg` (Universal / Cross-Platform)
If `ffmpeg` is available (macOS, Linux, Windows):

```bash
ffmpeg -i input.m4a -ac 1 -b:a 48k -c:a aac -movflags +faststart output.m4a
```

> **`-movflags +faststart` is mandatory:** In MP4/M4A containers, the time index and duration table (the `moov` atom) is written at the *end* of the file by default. `-movflags +faststart` moves the `moov` atom to the very beginning. Without it, browsers cannot seek along the timeline without downloading the entire file first.

#### Option B: macOS Native `afconvert` (Built into macOS)
If `ffmpeg` is not installed on macOS, use Apple's built-in `afconvert` (available on every Mac with zero install):

```bash
afconvert -f m4af -d aac -b 48000 -c 1 input.m4a output.m4a
```

`afconvert` produces an Apple AudioToolbox-native container with an exact 44.1 kHz timescale and no synthetic edit lists (`elst`), making it especially reliable for Safari and WebKit.

#### Option C: Windows
Windows does not include a native command-line audio transcoder comparable to `afconvert`. Modern Windows (10 and 11) includes `winget` pre-installed. Install `ffmpeg` in PowerShell with:

```powershell
winget install Gyan.FFmpeg
```
Then use the standard `ffmpeg` command from Option A.

---

## 3. Quarto chapter embedding pattern

Always embed the podcast near the top of the chapter, immediately following `{{< include "includes/WIP-callout.qmd" >}}` and prior to the first section header.

### Standard Callout Template

Use a Quarto `callout-note` with the `title` attribute, and wrap the `<audio>` tag in a Pandoc raw HTML block (` ```{=html} `) to avoid Pandoc AST parse warnings:

```markdown
::: {.callout-note collapse="false" icon="false" title="🎙️ Chapter Podcast: <Episode Title>"}

*An AI-generated discussion (NotebookLM) summarizing the core themes of this chapter.*

```{=html}
<audio id="chapter-podcast-audio" controls preload="auto" style="width: 100%; margin-top: 0.5em;">
  <source src="podcasts/<filename>.m4a" type="audio/mp4">
  Your browser does not support the audio element.
</audio>
<script>
(function() {
  function initAudio() {
    var audio = document.getElementById('chapter-podcast-audio');
    if (audio && (location.hostname === 'localhost' || location.hostname === '127.0.0.1')) {
      var src = audio.querySelector('source') ? audio.querySelector('source').src : audio.src;
      if (src && !audio.dataset.blobified) {
        audio.dataset.blobified = 'true';
        fetch(src)
          .then(function(res) { return res.blob(); })
          .then(function(blob) {
            var objectUrl = URL.createObjectURL(blob);
            var currentTime = audio.currentTime;
            var isPaused = audio.paused;
            audio.src = objectUrl;
            if (currentTime > 0) audio.currentTime = currentTime;
            if (!isPaused) audio.play();
          })
          .catch(function(err) { console.warn('Local audio blob fetch failed:', err); });
      }
    }
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initAudio);
  } else {
    initAudio();
  }
})();
</script>
```

[Download audio file (M4A)](podcasts/<filename>.m4a)

:::
```

---

## 4. Critical technical discoveries & gotchas

### A. Why the timeline slider snaps back on `localhost`
1. **HTTP Byte-Range Requests (RFC 7233):** When a user drags an audio slider to minute 5:00, the browser sends an HTTP request with a `Range: bytes=XXXXX-` header to request only that portion of the audio stream.
2. **Production vs. Development:**
   - **Production (GitHub Pages, Netlify, Nginx, Fastly CDN):** Fully supports HTTP Byte-Range requests and returns `206 Partial Content`. Timeline seeking works natively out of the box.
   - **Local Development (`quarto preview`):** Quarto's internal Deno web server does **not** support HTTP Range requests. It responds with `200 OK` (the entire stream from byte 0). When Chrome or Safari sees byte 0 returned instead of the requested offset, the browser's audio decoder cancels the seek and snaps the slider back.
3. **The Solution (The Local Blob Streaming Helper):**
   The inline `<script>` checks `location.hostname === 'localhost' || location.hostname === '127.0.0.1'`.
   - When on localhost, it fetches the 8 MB audio into an in-memory `Blob` (`URL.createObjectURL(blob)`). Because the audio lives directly in browser RAM, scrubbing and seeking work with 100% precision and zero snapping back.
   - When deployed to production, the script does nothing, leaving native HTTP streaming untouched.

### B. The `quarto preview` in-memory cache trap
`quarto preview` runs an in-memory development server. When large media files or inline raw HTML blocks are edited, `quarto preview` can continue serving stale in-memory cached pages without picking up external build artifacts.
- If audio changes or player controls do not respond in the browser, **stop `quarto preview` (`Ctrl + C`) and restart it.**
- Hard-refresh the browser tab (`Cmd + Shift + R`) to ensure media byte buffers are cleared.

---

## 5. Quick step-by-step checklist

1. **Export from NotebookLM:** Download the generated audio `.m4a` file.
2. **Compress:**
   ```bash
   ffmpeg -i input.m4a -ac 1 -b:a 48k -c:a aac -movflags +faststart chapters/podcasts/<Name>.m4a
   # or on Mac:
   afconvert -f m4af -d aac -b 48000 -c 1 input.m4a chapters/podcasts/<Name>.m4a
   ```
3. **Embed:** Paste the standard callout template into the top of the chapter `.qmd`.
4. **Test:** Run `quarto preview` and verify playback and time slider scrubbing.
