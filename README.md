PHP Build Tools
=============================

Downloads and optionally installs to local:
- box
- composer
- pdepend
- phing
- phpab
- phpcbf
- phpcov
- phpcpd
- phpcs
- phpdoc
- php-cs-fixer (v1.13.1)
- php-cs-fixer-v2 (latest)
- phpdox
- phploc
- phpmd
- phpunit
- sami

```bash
git clone https://github.com/robinradic/php-build-tools
cd php-build-tools

# Update all tools. Downloads the latest releases and put's em in the "bin" directory
./tools-update.sh

# Installs all tools to /usr/local/bin
./tools-install-local.sh
```


## Update the tools
```bash
./tools-update.sh
```

```
./tools-update.sh 
Submodule 'lib' (https://github.com/robinradic/radic-bash-lib) registered for path 'lib'
Cloning into 'lib'...
remote: Counting objects: 86, done.
remote: Total 86 (delta 0), reused 0 (delta 0), pack-reused 86
Unpacking objects: 100% (86/86), done.
Checking connectivity... done.
Submodule path 'lib': checked out '3c1f1d1c9ffedc054d65ad3a0e00c217dda1e919'
√ updated: composer
√ updated: php-cs-fixer
√ updated: php-cs-fixer-v2
√ updated: sami
√ updated: phpcov
√ updated: pdepend
√ updated: phing
√ updated: phpab
√ updated: phpcpd
√ updated: phpcs
√ updated: phpcbf
√ updated: phpdox
√ updated: phploc
√ updated: phpmd
√ updated: phpunit
√ updated: phpdoc
Box Installer
=============

Environment Check
-----------------

"-" indicates success.
"*" indicates error.

 - You have a supported version of PHP (>= 5.3.3).
 - You have the "phar" extension installed.
 - You have a supported version of the "phar" extension.
 - You have the "openssl" extension installed.
 - The "phar.readonly" setting is off.
 - The "detect_unicode" setting is off.
 - The "allow_url_fopen" setting is on.

Everything seems good!

Download
--------

 - Downloading manifest...
 - Reading manifest...
 - Downloading Box v2.7.5...
 - Checking file checksum...
 - Checking if valid Phar...
 - Making Box executable...

Box installed!
√ updated: box
```
