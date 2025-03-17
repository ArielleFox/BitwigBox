#!/bin/bash

# Check if a .deb file was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <deb-file>"
    exit 1
fi

# Extract base filename without .deb extension
BASECASE=$(basename "$1" .deb)

echo "Please be patient:"
echo "Converting $1 to RPM..."

# Convert .deb to .rpm
sudo alien --to-rpm --scripts "$1"

# Find the generated RPM file
RPM_FILE=$(find . -type f -name "${BASECASE}*.rpm" -print -quit)

if [ -z "$RPM_FILE" ]; then
    echo "Error: Failed to find generated RPM file."
    exit 1
fi


nohup rpm2cpio "$RPM_FILE" | cpio -idmv > rpm_$BASECASE.log 2>&1 &
APP_PID=$!
echo "Extracting RPM contents from $RPM_FILE with PID: $APP_PID..."
echo 'Logfile → rpm_$BASECASE.log'

echo 'Creating application folder: $BASECASE/'
mkdir -p $BASECASE

echo '	Moving files → $BASECASE/'
mv usr/ $BASECASE 2>/dev/null || :
bash  scripts/move_log_entries.sh rpm_$BASECASE.log $BASECASE
echo "Conversion and extraction completed successfully."
