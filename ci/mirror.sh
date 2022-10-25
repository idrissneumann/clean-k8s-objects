#!/bin/bash

REPO_PATH="${PROJECT_HOME}/clean-k8s-objects/"

cd "${REPO_PATH}" && git pull origin main || :
git push github main -f
git push internal main -f
git push pgitlab main -f
git push froggit main -f
exit 0
