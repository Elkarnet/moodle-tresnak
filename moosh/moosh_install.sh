#!/bin/bash

cd /opt/
# Bertsio zaharrak ezabatu
rm -Rf moosh*
# Bertsio berria deskargatu
#wget  https://moodle.org/plugins/download.php/21420/moosh_moodle38_2020042300.zip   # Moodle 3.11 betsiorako
wget https://moodle.org/plugins/download.php/23759/moosh_moodle310_2021032401.zip    # Moodle 4 bertsiorako

# Deskonprimatu
unzip moosh_moodle310_2021032401.zip
