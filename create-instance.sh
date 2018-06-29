#!/bin/bash 

ZONE=us-east1-c
PROJECT_NAME=$1
IMAGE=mycentos7
NAME=test

if [ $# -ne 1 ]; then 
    echo "Missing Project name Argument"
    echo "Usage: $0 <project-name>"
    exit 2
fi

gcloud projects list | grep $PROJECT_NAME &>/dev/null 
if [ $? -ne 0 ]; then 
    echo "Error!! Given Project does not exist"
    exit 1
fi

gcloud compute instances list | grep test &>/dev/null
if [ $? -eq 0 ]; then 
    echo "Error! Instance already exists"
    exit 1
fi

gcloud compute instances create $NAME --image=$IMAGE --image-project=$PROJECT_NAME --zone=$ZONE

