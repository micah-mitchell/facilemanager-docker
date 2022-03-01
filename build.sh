Version="4.2.0"


# Build Images
Version=$Version docker-compose build

# Add Tag
docker tag micahmitchell/facilemanager micahmitchell/facilemanager:$Version

# Upload Images
docker push micahmitchell/facilemanager:latest

docker push micahmitchell/facilemanager:$Version
