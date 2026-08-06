#!/bin/bash
set -e

# 1. Clone ISETCam into the container if not already present
if [ ! -d "/home/vscode/isetcam" ]; then
    echo "Cloning ISETCam repository..."
    git clone https://github.com/ISET/isetcam.git /home/vscode/isetcam
fi

# 2. Create the MATLAB user directory for startup scripts
mkdir -p /home/vscode/Documents/MATLAB

# 3. Write startup.m with absolute paths and subfolder support
cat << 'EOF' > /home/vscode/Documents/MATLAB/startup.m
% Add ISETCam and ALL subdirectories to the MATLAB path
addpath(genpath('/home/vscode/isetcam'));

% Initialize ISETCam
ieInit;

disp('===================================================');
disp('  ISETCam successfully loaded onto MATLAB path!    ');
disp('===================================================');
EOF

echo "Devcontainer environment setup complete."