lamp-packages:
  pkg.installed:
    - names:
      - apache2
      - mysql-server
      - mysql-client
      - python-mysqldb
      - python-mysql.connector
      - php-xml-parser
{% if grains['osrelease'] == '16.04' %}
      - php
      - php-curl
      - php-mysql
      - php-gd
      - php-mcrypt
      - libapache2-mod-php
{% else %}
      - php5
      - php5-curl
      - php5-mysql
      - php5-gd
      - php5-mcrypt
      - libapache2-mod-php5
      - apache2-mpm-prefork
{% endif %}