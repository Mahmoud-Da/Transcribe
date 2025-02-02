#!/bin/bash

# Check if a filename is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <video_file>"
    exit 1
fi

# Get the input video file
VIDEO_FILE="$1"

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
whisper "$BASENAME.wav" --language English

# Check if Whisper was successful
if [ $? -ne 0 ]; then
    echo "❌ Error: Whisper transcription failed!"
    exit 1
fi

# Delete the extracted audio file
echo "🗑️ Deleting audio file..."
rm "$BASENAME.wav"

echo "✅ Done! Check the transcript for '$BASENAME'."
