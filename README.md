PHP Build Tools
=============================

Largely taken from http://jenkins-php.org/.

- Transferred to Phing
- modified/added some stuff


### Overview
- Intended use as submodule
- Includes all of the major build tools as .phar archive.
- Includes boilerplate phing build, phpdox, phpmd and phpunit templates
- Includes jenkins job template, asuming http://jenkins-php.org/ has been installed
- Also takes into account travis-ci


### Installation
In your project directory create `build` dir
```sh
mkdir build
git submodule add -b master https://github.com/robinradic/php-build-tools build/tools
cp build/tools/tpl-phpdox.xml build/phpdox.xml
cp build/tools/tpl-phpmd.xml build/phpmd.xml
cp build/tools/tpl-phpunit.xml build/phpunit.xml
cp build/tools/tpl-travis-ci.xml build/travis-ci.xml
cp build/tools/tpl-build.xml build.xml # copy to root dir
# now you could optionally do something like
# phing to root dir
cp build/tools/phing.phar phing
# add it to gitignore
echo -e "\n/phing\n" >> .gitignore
# test it out
php phing
# create a script directory, with bootstrap.sh (use after cloning) and githooks
mkdir scripts
touch scripts/pre-commit
# etc...
```

### Examples
Any of my php