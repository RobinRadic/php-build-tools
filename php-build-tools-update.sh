#!/bin/bash

MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "${MYDIR}/lib/_lib.sh"

bash ./lib/git-submodule-update.sh

#########################
#   UPDATE PHAR FILES
#########################

# phar-composer
rm -f phar-composer.phar
wget http://www.lueck.tv/phar-composer/phar-composer.phar

# pdepend
rm -f pdepend.phar
wget http://static.pdepend.org/php/latest/pdepend.phar

# phing
rm -f phing.phar
wget http://www.phing.info/get/phing-latest.phar
mv phing-latest.phar phing.phar

# phpab
rm -f phpab.phar
wget http://phpab.net/phpab-1.16.1.phar
mv phpab-1.16.1.phar phpab.phar

# phpcpd
rm -f phpcpd.phar
wget https://phar.phpunit.de/phpcpd.phar

# phpcs
rm -f phpcs.phar
wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar

# phpcbf
rm -f phpcbf.phar
wget https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar

# phpdox
rm -f phpdox.phar
wget http://phpdox.de/releases/phpdox.phar

# phploc
rm -f phploc.phar
wget https://phar.phpunit.de/phploc.phar

# phpmd
rm -f phpmd.phar
wget http://static.phpmd.org/php/latest/phpmd.phar

# phpunit
rm -f phpunit.phar
wget https://phar.phpunit.de/phpunit.phar

# phpdoc
rm -f phpdoc.phar
wget http://www.phpdoc.org/phpDocumentor.phar
mv phpDocumentor.phar phpdoc.phar

# phrocco
rm -f phrocco.phar
php phar-composer.phar build rossriley/phrocco:dev-master

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
