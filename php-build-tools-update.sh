#!/bin/bash

MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "${MYDIR}/lib/_lib.sh"

bash ./lib/git-submodule-update.sh

#########################
#   UPDATE PHAR FILES
#########################

# phar-composer
Exec rm -f phar-composer.phar
Exec wget http://www.lueck.tv/phar-composer/phar-composer.phar

# pdepend
Exec rm -f pdepend.phar
Exec wget http://static.pdepend.org/php/latest/pdepend.phar

# phing
Exec rm -f phing.phar
Exec wget http://www.phing.info/get/phing-latest.phar
Exec mv phing-latest.phar phing.phar

# phpab
Exec rm -f phpab.phar
Exec wget http://phpab.net/phpab-1.16.1.phar
Exec mv phpab-1.16.1.phar phpab.phar

# phpcpd
Exec rm -f phpcpd.phar
Exec wget https://phar.phpunit.de/phpcpd.phar

# phpcs
Exec rm -f phpcs.phar
Exec wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar

# phpcbf
Exec rm -f phpcbf.phar
Exec wget https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar

# phpdox
Exec rm -f phpdox.phar
Exec wget http://phpdox.de/releases/phpdox.phar

# phploc
Exec rm -f phploc.phar
Exec wget https://phar.phpunit.de/phploc.phar

# phpmd
Exec rm -f phpmd.phar
Exec wget http://static.phpmd.org/php/latest/phpmd.phar

# phpunit
Exec rm -f phpunit.phar
Exec wget https://phar.phpunit.de/phpunit.phar

# phpdoc
Exec rm -f phpdoc.phar
Exec wget http://www.phpdoc.org/phpDocumentor.phar
Exec mv phpDocumentor.phar phpdoc.phar

# phrocco
Exec rm -f phrocco.phar
Exec php phar-composer.phar build rossriley/phrocco:dev-master

# box2
curl -LSs https://box-project.github.io/box2/installer.php | php
chmod +x box.phar



#########################
#   POST UPDATE STUFF
#########################

# chmod all PHAR archives to be executable
chmod +x *.phar

# ensure pre-commit hook
cp -f ./scripts/pre-commit ./.git/hooks/pre-commit >> /dev/null
chmod +x ./.git/hooks/pre-commit

# tag it on git
bash ${MYDIR}/lib/git-tag.sh patch
