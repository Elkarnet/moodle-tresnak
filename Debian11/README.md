# Debian 10etik Debian 11ra eguneratzerakoan kontutan izan beharrekoak

PHP bertsioa aldatzen da 7.3tik 7.4 bertsiora. Honek esan nahi du, aurreko Moodle betsioan genituen php pertsonalizazioak ez direla automatikoki azalduko php7.4 bertsioan, aurreko bertsioan jarri genituen aldaketak bertsio berrira ekarri beharko ditugu.

Apache2+FPM erabiltzerakoan, pakete hauek eguneratu behar dira

    apt-get install php7.4-cli php7.4-common php7.4-curl php7.4-fpm php7.4-gd php7.4-intl php7.4-json php7.4-ldap php7.4-mbstring php7.4-mysql php7.4-opcache php7.4-pspell php7.4-readline php7.4-soap php7.4-xml php7.4-xmlrpc php7.4-zip 
    
Dokumentu hau idazterakoan (2022/07/04) php7.4-fpm zerbitzuak akats bat ematen du /run/php/ karpeta ez duelako aurkitzen, Bug itxura du. [Hemen](https://stackoverflow.com/questions/64257440/cant-bind-php7-4-fpm-listening-socket-because-folder-does-not-exist) azaltzen dutenari jarraituz, konpondu degu:


