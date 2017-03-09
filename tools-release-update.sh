#!/usr/bin/env bash


MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

bash ${MYDIR}/php-build-tools-update.sh

# ensure pre-commit hook
cp -f ./scripts/pre-commit ./.git/hooks/pre-commit >> /dev/null
chmod +x ./.git/hooks/pre-commit

# tag it on git
bash ${MYDIR}/lib/bin/git-tag.sh patch
