#!/bin/bash

# Hau egin aurretik, backup bat egitea gomendatzen da.
# Zerbitzaria birtualizatuta badugu, hasi aurretik snapshot bat egitea ere ondo legoke.

# Enable maintenance mode
/usr/bin/php /var/www/html/admin/cli/maintenance.php --enable 

# Git bidez deskargatu 4 adarreko bertsioa. Lerro hau eguneatu beharko genuke adar berri bateko azken bertsioa deskargatzeko.
# https://github.com/moodle/moodle/branches

cd /opt/moodle
git branch --track MOODLE_400_STABLE origin/MOODLE_400_STABLE
git checkout MOODLE_400_STABLE
git pull

# Eguneraketan /var/www/html karpeta ezabatuko dugunez, barruan dauzagun konfigurazio eta plugin karpetak beste nonbaitera mugitu behar ditugu.

# config.php kopiatu. Plantillak edo pertsonalizatutako gauzarik bagenu, hau da htlm karpetatik kanpora kopiatzeko unea
cp /var/www/html/config.php /var/www/

# Erabiltzen ari garen pluginak leku ezberdinetan kokatuta egongo dira (mod, theme, format, report, .... azpikarpetetan).
# htlm karpeta ezabatuko denez, hau da plugin hauek beste nonbaitera mugitzeko unea. Adibidez:

# PLUGIN Mugimendu hasiera

mv /var/www/html/mod/bigbluebuttonbn /var/www/  
mv /var/www/html/course/format/buttons /var/www/ 
mv /var/www/html/course/format/tiles /var/www/ 
mv /var/www/html/course/format/onetopic /var/www/ 
mv /var/www/html/mod/attendance /var/www/ 

mv /var/www/html/mod/subcourse /var/www/ 
mv /var/www/html/report/coursesize /var/www/ 
mv /var/www/html/mod/mindmap /var/www 

# PLUGIN Mugimendu bukaera

# Bertsio zaharra ezabatu
rm -rf /var/www/html/*

# git bidez deskagatu duguna html karpetan kopiatu
cp -pa /opt/moodle/* /var/www/html/

# aurrez kopiatu degun config.php bere lekuan jarri
cp /var/www/config.php /var/www/html/

# Aurrez lekuz aldatu ditugun plugin karpetak dagokien lekura mugitu

# PLUGIN Mugimendu hasiera
mv /var/www/bigbluebuttonbn /var/www/html/mod/bigbluebuttonbn  #bbb plugina
mv /var/www/buttons /var/www/html/course/format/buttons # format_buttons plugina
mv /var/www/tiles /var/www/html/course/format/tiles # format_tiles plugina
mv /var/www/onetopic /var/www/html/course/format/onetopic # onetopic plugina
mv /var/www/attendance /var/www/html/mod/attendance  # attendance plugina
mv /var/www/subcourse /var/www/html/mod
mv /var/www/coursesize /var/www/html/report
mv /var/www/mindmap /var/www/html/mod/
# PLUGIN Mugimendu bukaera


# upgrade-a martxan jarri. 
# Hau eskuz egiten degun prozesua da, akatsen bat emango balu kontsolan ikusiko genuke

# /usr/bin/php /var/www/html/admin/cli/upgrade.php --non-interactive
/usr/bin/php /var/www/html/admin/cli/upgrade.php

# maintenance egoeratik atera
/usr/bin/php /var/www/html/admin/cli/maintenance.php --disable

/etc/init.d/apache2 restart
