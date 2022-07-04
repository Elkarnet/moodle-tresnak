#!/bin/bash

mkdir -p /backup/moodle_backup
mkdir -p /backup/moodle_backup/moodle_data
mkdir -p /backup/moodle_backup/html


# MAINTENANCE egoeran jarri haurretik lehen RSYNC bat egiten degu, eta horrela
# badakigu MAINTENANCE egoeran sartzen denean RSYNCa azkarrago bukatu dela


# RSYNC Moodle folder
rsync --stats -avz  --times --perms --links --delete --delete --exclude 'cache'  --exclude 'sessions' --exclude 'trashdir' --exclude 'temp'  /var/moodledata/ /backup/moodle_backup/moodle_data/

# RSYNC html folder
rsync --stats -avz  --times --perms --links --delete  /var/www/html/ /backup/moodle_backup/html/


# Enable maintenance mode
/usr/bin/php /var/www/html/admin/cli/maintenance.php --enable 

# DB Backup
# MYSQLPASAHIZA ordeztu zure pasahitzarekin
mysqldump -umoodleuser -pMYSQLPASAHIZA --opt moodledb > /backup/moodle_backup/moodle_backup.sql

# RSYNC Moodle folder
rsync --stats -avz  --times --perms --links --delete --delete --exclude 'cache'  --exclude 'sessions' --exclude 'trashdir' --exclude 'temp'  /var/moodledata/ /backup/moodle_backup/moodle_data/

# RSYNC html folder
rsync --stats -avz  --times --perms --links --delete  /var/www/html/ /backup/moodle_backup/html/

# Maintenance egoeratik atera
/usr/bin/php /var/www/html/admin/cli/maintenance.php --disable

# bzip2 the sql dump
rm -f /backup/moodle_backup/moodle_backup.sql.bz2
cd /backup/moodle_backup/
bzip2 /backup/moodle_backup/moodle_backup.sql
