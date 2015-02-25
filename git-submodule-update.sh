#!/bin/bash

MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "${MYDIR}/_main.sh"


if [ "$is_help" == "true" ]; then
    cat << EOF
$(f bold)$(fc green)Git Submodule Updater$(f off)

$(f bold)Name:          $(f off)$(fc cyan)git-submodule-update.sh $(f off)
$(f bold)Description:   $(f off)Updates submodules in the current working directory
$(f bold)Arguments:     $(f off)
    -h                     $(fc orange)(optional)$(f off) Show this help overview
    -v                     $(fc orange)(optional)$(f off) Enable verbose output
    -d                     $(fc orange)(optional)$(f off) Enable debug output
    -p <path>              $(fc orange)(optional)$(f off) only update specified submodule <path>
$(f bold)Examples:      $(f off)
    $(fc green)# Update all submodules $(f off)
    ./build/tools/git-submodule-update.sh
    $(fc green)# Update submodule lib/mysubmod1 $(f off)
    ./build/tools/git-submodule-update.sh -p lib/mysubmod1
    $(fc green)# Update submodule lib/mysubmod1 and show verbose and debug output$(f off)
    ./build/tools/git-submodule-update.sh -v -d -p lib/mysubmod1

$(fc grey)Always execute scripts from the working directory, like shown in the examples$(f off)
EOF
    exit 0
fi

Echo "Doing submodule update in ${PWD}"
Exec git submodule update --init --recursive --remote --force ${pflag}

function _submodule {
    ROOT_DIR="$PWD"
    SMPATH=$1
    cd "$SMPATH"
    BRANCH="$(git config -f $ROOT_DIR/.gitmodules submodule.$SMPATH.branch)"
    Exec git fetch --all
    Exec git checkout "$BRANCH"
    Exec git pull origin "$BRANCH"
    Echo success "Updated submodule $SMPATH"
    cd "$ROOT_DIR"

}

if [ "$pflag" == "" ]; then
    Echo verbose "Dont got mflag"
    dirs=$(git submodule status --recursive)
    for word in $dirs; do
        if [ -d "$word" ]; then
            _submodule "$word"
        fi
    done
    Echo success "Updated submodules"
    #Exec `git submodule foreach -q --recursive 'branch="$(git config -f $toplevel/.gitmodules submodule.$name.branch)" && git fetch --all > /dev/null 2>&1  && git checkout $branch  > /dev/null 2>&1 && git pull  > /dev/null 2>&1'`
else
    Echo verbose "Got a mflag: ${pflag}"
    _submodule "$pflag"
fi
