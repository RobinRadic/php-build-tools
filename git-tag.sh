#!/bin/bash

MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "${MYDIR}/_main.sh"



if [ "$is_help" == "true" ]; then
    cat << EOF
$(f bold)$(fc green)Git Auto Incremental Semantic Versioning Tagger$(f off)

$(f bold)Name:          $(f off)$(fc cyan)git-tag.sh $(f off)
$(f bold)Desc:          $(f off)- Checks out the current branch, pushes it to remote
$(f bold)               $(f off)- Increments the given <type> by 1, compared to the latest tag, creates it and finally pushes it
$(f bold)Arguments:     $(f off)
    -t <type>              $(fc red)required$(f off) [patch|minor|major] - The type of increment you want to do
    -h                     $(fc orange)optional$(f off) Show this help overview
    -v                     $(fc orange)optional$(f off) Enable verbose output
    -d                     $(fc orange)optional$(f off) Enable debug output
$(f bold)Examples:      $(f off)
    ./build/tools/git-tag.sh -t patch   $(fc green)# current(v1.2.1) to v1.2.2 $(f off)
    ./build/tools/git-tag.sh -t minor   $(fc green)# current(v1.2.2) to v1.3.0 $(f off)
    ./build/tools/git-tag.sh -t patch   $(fc green)# current(v1.3.0) to v1.3.1 $(f off)
    ./build/tools/git-tag.sh -t major   $(fc green)# current(v1.3.1) to v2.0.0 $(f off)

$(fc grey)Always execute scripts from the working directory, like shown in the examples$(f off)
EOF
    exit 0
fi

Echo "Doing $(f bold)$(fc orange)git-tag$(f off) $(f bold)${PWD}$(f off)"

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
