#!/bin/bash

MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "${MYDIR}/lib/_lib.sh"

LOCATION="/usr/local/bin"

function _move {
    local NAME=$1
    sudo cp -f "${NAME}.phar" "${LOCATION}/${NAME}"
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


