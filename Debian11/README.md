Gure kasuan Moodle 3.11 Debian 10 baten gainean geneukan, beraz lehen pausua Debian eguneratzea izan da. Hau egin ondoren, hemen azaltzen dena egin behar izan degu PHP bertsio berrira egokitzeko.


# Debian 10etik Debian 11ra eguneratzerakoan kontutan izan beharrekoak

PHP bertsioa aldatzen da 7.3tik 7.4 bertsiora. Honek esan nahi du, aurreko Moodle betsioan genituen php pertsonalizazioak ez direla automatikoki azalduko php7.4 bertsioan, aurreko bertsioan jarri genituen aldaketak bertsio berrira ekarri beharko ditugu.

Apache2+FPM erabiltzerakoan, pakete hauek eguneratu behar dira

    apt-get install php7.4-cli php7.4-common php7.4-curl php7.4-fpm php7.4-gd php7.4-intl php7.4-json php7.4-ldap php7.4-mbstring php7.4-mysql php7.4-opcache php7.4-pspell php7.4-readline php7.4-soap php7.4-xml php7.4-xmlrpc php7.4-zip 
    
Dokumentu hau idazterakoan (2022/07/04) php7.4-fpm zerbitzuak akats bat ematen du /run/php/ karpeta ez duelako aurkitzen, Bug itxura du. [Hemen](https://stackoverflow.com/questions/64257440/cant-bind-php7-4-fpm-listening-socket-because-folder-does-not-exist) azaltzen dutenari jarraituz, konpondu degu:

1. [php7.4-arrankatu-aurretik.sh](https://github.com/Elkarnet/moodle-tresnak/blob/main/Debian11/php7.4-arrankatu-aurretik.sh) scripta sortu, adibidez /root/scritps/ karpetan
2. Zerbitzaria berrabiarazi bakoitzean exekutatzeko crontab-ean lerro hau gehitu: @reboot  /root/scripts/php7.4-arrankatu-aurretik.sh

apt-get agindua exekutatu

    apt install -f 

php7.3-fpm desgaitu eta php7.4-fpm gaitu

    a2disconf php7.3-fpm 
    a2enconf php7.4-fpm

Lehen  /etc/php/7.3/fpm/php.ini  fitxategian eginiko pertsonalizazioak kontutan izan /etc/php/7.4/fpm/php.ini fitxategian gehitzeko. Ohitura on bat izaten da fitxategi hauetan gauzak aldatzerakoan, komentario moduan erakundearen izena jartzea, horrela gero azkarrago identifikatu daitezke egin izan diren aldaketak. 

# /etc/php/7.4/fpm/php.ini
    ; IMH 
    max_input_vars = 5000
    post_max_size = 2200M  
    opcache.enable = 1
    opcache.memory_consumption = 256
    opcache.max_accelerated_files = 11300
    opcache.max_wasted_percentage= 20
    opcache.use_cwd = 1
    opcache.validate_timestamps = 1
    opcache.save_comments = 1
    opcache.enable_file_override = 0

# /etc/php/7.4/fpm/pool.d/www.conf

    ; IMH https://chrismoore.ca/2018/10/finding-the-correct-pm-max-children-settings-for-php-fpm/
    pm.start_servers = 3
    pm.min_spare_servers = 2
    pm.max_spare_servers = 5
    pm.max_children = 10


PHP 7.3 ez dugunez gehiago erabiliko garbiketa egin

    apt-get purge php7.3*

Eta zerbitzaria berrabiarazi

    reboot

