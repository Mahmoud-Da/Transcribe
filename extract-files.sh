#!/bin/bash

# here we get the files from the container
# get the container ID
container_id=$(docker ps -q --filter "ancestor=transcribe-app")

docker cp "$container_id:/app/output/" ./output/
