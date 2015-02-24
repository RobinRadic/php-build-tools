#!/bin/sh

TAG_LAST="$(git describe --abbrev=0 --tags)"
TAG_PATCH="$(git describe --abbrev=0 --tags | cut -f 3 -d .)"
TAG_MINOR="$(git describe --abbrev=0 --tags | cut -f 2 -d .)"
TAG_MAJOR="$(git describe --abbrev=0 --tags | cut -f 1 -d . | sed -e 's/v//g')"

if [ "$1" = "patch" ]; then
    NEW_TAG="${TAG_MAJOR}.${TAG_MINOR}.$((TAG_PATCH+1))"
elif [ "$1" = "minor" ]; then
    NEW_TAG="${TAG_MAJOR}.$(($TAG_MINOR+1)).0"
elif [ "$1" = "major" ]; then
    NEW_TAG="$(($TAG_MAJOR+1)).0.0"
elif [ "$1" = "debug-remove-all-danger" ]; then
    git tag | while read line ; do git tag -d ${line}; git push -u origin :refs/tags/${line}; done
    exit 0
else
    echo "Failed. Specify version bump type. Usage: './tag.sh [patch|minor|major]'"
    exit 1
fi


git add -A
NOW=$(date +"%d-%m-%Y %T")
git commit -m "Tagging ${NEW_TAG}"
git push -u origin master

git tag -a ${NEW_TAG} -m "Tagged: ${NEW_TAG} @ ${NOW}"
git push -u origin ${NEW_TAG}
