#!/bin/bash

MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "${MYDIR}/_main.sh"

LOCATION="/usr/local/bin"

function _move {
    local NAME=$1
    sudo mv -f "${NAME}.phar ${LOCATION}/${NAME}"
    sudo chmod +x "${LOCATION}/${NAME}" # just to be sure
}

_move phar-composer
_move pdepend
_move phing
_move phpab
_move phpcpd
_move phpcs
_move phpcbf
_move phpdox
_move phploc
_move phpmd
_move phpunit
_move phpdoc
_move phrocco


