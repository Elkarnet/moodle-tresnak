#!/bin/bash
# bash script to mkdir php7.4 socket on reboot to make nginx work correctly because it doesn't automatically for whatever reason
# https://stackoverflow.com/questions/64257440/cant-bind-php7-4-fpm-listening-socket-because-folder-does-not-exist


mkdir --mode=07500 /run/php
chown www-data:www-data /run/php

systemctl restart php7.4-fpm
