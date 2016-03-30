#!/bin/bash

git submodule update --init --remote --recursive --force

MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "${MYDIR}/lib/_lib.sh"

rm -rf $MYDIR/bin >> /dev/null
mkdir $MYDIR/bin >> /dev/null

_mv() {
    Exec mv $1.phar bin/$1
    Exec chmod +x bin/$1
}

#########################
#   UPDATE PHAR FILES
#########################

# composer
Exec rm -f composer.phar
Exec wget https://getcomposer.org/composer.phar
_mv composer
Echo success "updated: composer"

# phar-composer
Exec rm -f phar-composer.phar
Exec wget http://www.lueck.tv/phar-composer/phar-composer.phar
_mv phar-composer
Echo success "updated: phar-composer"

# sami
Exec rm -f sami.phar
Exec wget http://get.sensiolabs.org/sami.phar
_mv sami
Echo success "updated: sami"

# phpcov
Exec rm -f phpcov.phar
Exec wget https://phar.phpunit.de/phpcov.phar
_mv phpcov
Echo success "updated: phpcov"

# pdepend
Exec rm -f pdepend.phar
Exec wget http://static.pdepend.org/php/latest/pdepend.phar
_mv pdepend
Echo success "updated: pdepend"

# phing
Exec rm -f phing.phar
Exec wget http://www.phing.info/get/phing-latest.phar
Exec mv phing-latest.phar bin/phing
Echo success "updated: phing"

# phpab
Exec rm -f phpab.phar
Exec wget http://phpab.net/phpab-1.16.1.phar
Exec mv phpab-1.16.1.phar bin/phpab
Echo success "updated: phpab"

# phpcpd
Exec rm -f phpcpd.phar
Exec wget https://phar.phpunit.de/phpcpd.phar
_mv phpcpd
Echo success "updated: phpcpd"

# phpcs
Exec rm -f phpcs.phar
Exec wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
_mv phpcs
Echo success "updated: phpcs"

# phpcbf
Exec rm -f phpcbf.phar
Exec wget https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
_mv phpcbf
Echo success "updated: phpcbf"

# phpdox
Exec rm -f phpdox.phar
Exec wget http://phpdox.de/releases/phpdox.phar
_mv phpdox
Echo success "updated: phpdox"

# phploc
Exec rm -f phploc.phar
Exec wget https://phar.phpunit.de/phploc.phar
_mv phploc
Echo success "updated: phploc"

# phpmd
Exec rm -f phpmd.phar
Exec wget http://static.phpmd.org/php/latest/phpmd.phar
_mv phpmd
Echo success "updated: phpmd"

# phpunit
Exec rm -f phpunit.phar
Exec wget https://phar.phpunit.de/phpunit.phar
_mv phpunit
Echo success "updated: phpunit"

# phpdoc
Exec rm -f phpdoc.phar
Exec wget http://www.phpdoc.org/phpDocumentor.phar
Exec mv phpDocumentor.phar phpdoc.phar
_mv phpdoc
Echo success "updated: phpdoc"

# phrocco
Exec rm -f phrocco.phar
Exec php bin/phar-composer build rossriley/phrocco:dev-master
mv phrocco.phar bin/phrocco
Echo success "updated: phrocco"

# box2
curl -LSs https://box-project.github.io/box2/installer.php | php
chmod +x box.phar
_mv box
Echo success "updated: box"



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
