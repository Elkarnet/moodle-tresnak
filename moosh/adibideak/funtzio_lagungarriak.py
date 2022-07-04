#!/usr/bin/env python3
import subprocess

import time
import datetime
import os

def ikastaro_datak_reseteatu(ikastaro_kodea):
    # Ikasturte berriko hasiera eta bukaerak
    eguna = datetime.datetime(2022, 9, 9, 0, 0)
    startdate = time.mktime(eguna.timetuple())

    eguna = datetime.datetime(2023, 7, 1, 0, 0)
    enddate = time.mktime(eguna.timetuple())

    command = "sudo -uwww-data php /opt/moosh/moosh.php -p /var/www/html course-config-set course %s startdate %s " % (ikastaro_kodea,startdate)
    subprocess.call(command.split())
    command = "sudo -uwww-data php /opt/moosh/moosh.php -p /var/www/html course-config-set course %s enddate %s " % (ikastaro_kodea,enddate)
    subprocess.call(command.split())


def ikastaroan_matrikulatu(erabiltzaile_zerrenda,ikastaroa,rola):  
    for erabiltzaile in erabiltzaile_zerrenda:
        command = "sudo -uwww-data php /opt/moosh/moosh.php -p /var/www/html course-enrol -r %s -i %d %s " % (rola,int(ikastaroa),erabiltzaile)
        subprocess.call(command.split())


def ikastaroa_reset(ikastaro_kodea,manager_taldea):
# Ez det lortu subprocess erabiliz funtzionatzeak, akatsa ematen du. Hau deprekated dago, baina oraingoz horrela dijua ...   
    command = "sudo -uwww-data php /opt/moosh/moosh.php -p /var/www/html course-reset -s 'reset_forum_all=1 reset_data_notenrolled=1 unenrol_users=5,' %s " % (int(ikastaro_kodea))
    print (command)
    os.system(command)

    ikastaro_datak_reseteatu(ikastaro_kodea)
    ikastaroan_matrikulatu(manager_taldea, int(ikastaro_kodea),'manager')

