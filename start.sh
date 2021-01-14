#!/bin/bash

gradle build

docker build . -t app-lambda:latest

docker run -p 9000:8080 app-lambda:latest
