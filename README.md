# Transcribe
## Using with Docker
### 1.add the file in this location
```bash
src/inputs
```

### 1.build the image
```bash
docker compose build
```

### 2.run the container
```bash
docker compose up
```

### 3.enter to the container
```bash
docker run -it --rm transcribe-app
```

### 4.inside the container run the script
```bash
.//transcribe.sh FILENAME LANGUAGE
```

### 5.without terminate the running container open new shell tap and run:
1. for the first time
```bash
chmod +x transcribe.sh
```

2. run the script to extract the files
```bash
./extract-files.sh
```
NOTE: when upload/delete file from src/inputs rebuild the Image

## Using Locally
### Installation Mac

1. brew install ffmpeg
2. pip install openai-whisper

### How to use:

1. chmod +x transcribe.sh
2. ./transcribe.sh example_video.mp4 English


# Related References

### Whisper
https://openai.com/index/whisper/

### ffmpeg
https://www.ffmpeg.org/

### pip
https://pypi.org/project/pip/

