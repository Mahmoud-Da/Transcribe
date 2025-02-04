# NOTE: in the the latest version pip has a bug
ARG PYTHON_VERSION=3.11


FROM python:$PYTHON_VERSION-slim AS python

WORKDIR /app

COPY ./src .

RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3-pip \
    build-essential \
    python3-dev && \
    pip install --upgrade pip && \
    pip install openai-whisper && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN chmod +x transcribe.sh collect-files.sh

CMD ["bash"]
