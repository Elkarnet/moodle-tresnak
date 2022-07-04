#!/usr/bin/env python3
import subprocess
import time
import datetime

from funtzio_lagungarriak import *
from reseteatzeko_kategoria_ikastaroak import *

# KONTUZ: SCRIPT honek reseteatzeko_kategoria_ikastaroak.py fitxategian dauden ikastaro kodeak resteatuko ditu
# Konturatu gabe triskantzak ez egiteko, hurrengo lerroa komentatu beharko dezu, hori egin ezean script honek akatsa emango du
LERRO HAU KOMENTATU

for kategoria in reseteatzeko_kategoria_zerrenda:
    print ('###########################################################')
    print(kategoria)
    print ('###########################################################')

    komandoa = 'sudo -uwww-data php /opt/moosh/moosh.php -p /var/www/html course-list -c %s' % (kategoria['goiko_kategoria'])
    proc = subprocess.Popen(['/bin/bash', '-c', komandoa],stdout=subprocess.PIPE)

    ikastaro_zerrenda=[]

    while True:
        line = proc.stdout.readline()
        lerroa= str(line.decode('utf-8').rstrip()).replace('"', '')
        ikastaro1 = lerroa.split(',')
        ikastaro_zerrenda.append(ikastaro1[0])
        if not line:
            break

    ikastaro_zerrenda.remove('id')
    ikastaro_zerrenda.remove('')

    print(ikastaro_zerrenda)

    for ikastaro in ikastaro_zerrenda:
        if ikastaro in kategoria['hauek_ez_reseteatu']:
            print(ikastaro, "EZ RESET ..............................")
        else:
            print(ikastaro, "BAI RESET")
            ikastaroa_reset(ikastaro,kategoria['Kudeatzaileak'])   


