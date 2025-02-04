#!/bin/bash

# Check if a filename and language are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <video_file> <language>"
    exit 1
fi

# Get the input video file and language
VIDEO_FILE="$1"
LANGUAGE="$2"

# Check if the file exists
if [ ! -f "$VIDEO_FILE" ]; then
    echo "Error: File '$VIDEO_FILE' not found!"
    exit 1
fi

# Extract filename without extension
BASENAME=$(basename "$VIDEO_FILE" | sed 's/\.[^.]*$//')

# Extract audio using FFmpeg (supports any video format)
echo "🎤 Extracting audio from '$VIDEO_FILE'..."
ffmpeg -i "$VIDEO_FILE" -q:a 0 -map a "$BASENAME.wav" -y

# Check if FFmpeg was successful
if [ $? -ne 0 ]; then
    echo "❌ Error: Failed to extract audio!"
    exit 1
fi

# Run Whisper transcription
echo "📝 Transcribing audio..."
whisper "$BASENAME.wav" --language "$LANGUAGE"

# Check if Whisper was successful
if [ $? -ne 0 ]; then
    echo "❌ Error: Whisper transcription failed!"
    exit 1
fi

# Delete the extracted audio file
echo "🗑️ Deleting audio file..."
rm "$BASENAME.wav"

echo "✅ Done! Check the transcript for '$BASENAME'."

# Note: collect the output
if [ -f "collect-files.sh" ]; then
    ./collect-files.sh
fi
