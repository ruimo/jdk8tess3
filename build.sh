#!/bin/sh
docker build --no-cache -t ruimo/jdk8tess3:${TAG_NAME:-latest} .
