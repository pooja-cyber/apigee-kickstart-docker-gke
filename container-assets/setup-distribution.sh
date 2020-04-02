#!/bin/bash

if [ ! -d /app/code/vendor ]; then
    composer install --working-dir=/app/code
    # remove embeded git repositories
    find /app/code -mindepth 2 -type d -name .git | xargs rm -rf
fi

cp /app/container-assets/drush.sh /usr/local/bin/drush && chmod 755 /usr/local/bin/drush

# Use the settings file which has been parameterized using Environment variables
cp -f /app/container-assets/parameterized.settings.php /app/code/web/sites/default/settings.php

# fix permissions
chown -R www-data.www-data /app/code/web/sites/default/settings.php \
    && chmod -R 664 /app/code/web/sites/default/settings.php

#create the file system for public, private, temp files
mkdir -p /app/code/web/sites/default/files \
    && mkdir -p /app/drupal-files/private \
    && mkdir -p /app/drupal-files/config \
    && mkdir -p /app/drupal-files/temp