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
Echo success "updated: phar-composer"

# pdepend
Exec rm -f pdepend.phar
Exec wget http://static.pdepend.org/php/latest/pdepend.phar
Echo success "updated: pdepend"

# phing
Exec rm -f phing.phar
Exec wget http://www.phing.info/get/phing-latest.phar
Exec mv phing-latest.phar phing.phar
Echo success "updated: phing"

# phpab
Exec rm -f phpab.phar
Exec wget http://phpab.net/phpab-1.16.1.phar
Exec mv phpab-1.16.1.phar phpab.phar
Echo success "updated: phpab"

# phpcpd
Exec rm -f phpcpd.phar
Exec wget https://phar.phpunit.de/phpcpd.phar
Echo success "updated: phpcpd"

# phpcs
Exec rm -f phpcs.phar
Exec wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
Echo success "updated: phpcs"

# phpcbf
Exec rm -f phpcbf.phar
Exec wget https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
Echo success "updated: phpcbf"

# phpdox
Exec rm -f phpdox.phar
Exec wget http://phpdox.de/releases/phpdox.phar
Echo success "updated: phpdox"

# phploc
Exec rm -f phploc.phar
Exec wget https://phar.phpunit.de/phploc.phar
Echo success "updated: phploc"

# phpmd
Exec rm -f phpmd.phar
Exec wget http://static.phpmd.org/php/latest/phpmd.phar
Echo success "updated: phpmd"

# phpunit
Exec rm -f phpunit.phar
Exec wget https://phar.phpunit.de/phpunit.phar
Echo success "updated: phpunit"

# phpdoc
Exec rm -f phpdoc.phar
Exec wget http://www.phpdoc.org/phpDocumentor.phar
Exec mv phpDocumentor.phar phpdoc.phar
Echo success "updated: phpdoc"

# phrocco
Exec rm -f phrocco.phar
Exec php phar-composer.phar build rossriley/phrocco:dev-master
Echo success "updated: phrocco"

# box2
curl -LSs https://box-project.github.io/box2/installer.php | php
chmod +x box.phar
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
