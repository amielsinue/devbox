#!/bin/bash

# Install PHP Unit
cd /usr/local/bin/
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
mv phpunit.phar phpunit
