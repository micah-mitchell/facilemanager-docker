#!/bin/bash

Version="4.6.1"

# Build Images
Version=$Version docker compose build

# Add Tag
docker tag myahmitchell/facilemanager myahmitchell/facilemanager:$Version

# Upload Images
docker push myahmitchell/facilemanager:latest

docker push myahmitchell/facilemanager:$Version
