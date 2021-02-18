#!/bin/bash

gradle build

export AWS_SECRET_ACCESS_KEY=`grep 'aws_secret_access_key' ~/Downloads/credentials | sed -e 's/aws_secret_access_key =.//' | tail -n 1`
export AWS_SESSION_TOKEN=`grep 'aws_session_token' ~/Downloads/credentials | sed -e 's/aws_session_token =.//' | tail -n 1`
export AWS_ACCESS_KEY_ID=`grep 'aws_access_key_id' ~/Downloads/credentials | sed -e 's/aws_access_key_id =.//' | tail -n 1`

docker build . -t app-lambda:latest

docker run -e AWS_DEFAULT_REGION=ca-central-1 \
           -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
           -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
           -e AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN} \
           -p 9000:8080 app-lambda:latest