#!/bin/sh



TAG_LAST="$(git describe --abbrev=0 --tags)"
TAG_PATCH="$(git describe --abbrev=0 --tags | cut -f 3 -d .)"
TAG_MINOR="$(git describe --abbrev=0 --tags | cut -f 2 -d .)"
TAG_MAJOR="$(git describe --abbrev=0 --tags | cut -f 1 -d .)"

NEW_TAG="${TAG_MAJOR}.${TAG_MINOR}.$(($TAG_PATCH+1))"

git add -A
NOW=$(date +"%d-%m-%Y %T")
git commit -m "Tagging ${NEW_TAG}"
git push -u origin master

tag ${NEW_TAG} "Tagged: ${NEW_TAG} @ ${NOW}"