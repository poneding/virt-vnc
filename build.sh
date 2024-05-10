#!/bin/bash

# Build the project
docker buildx create --name mybuilder --use
docker buildx build --push --platform linux/amd64,linux/arm64,linux/arm/v7 -t poneding/virt-vnc .