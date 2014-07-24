clear-www:
  file.absent:
    - name: /var/www/index.html

get_wordpress:
  cmd.run:
    - name: 'wget -O latest.tar.gz http://wordpress.org/latest.tar.gz && tar xzf latest.tar.gz'
    - cwd: /tmp/
    - unless: cat /var/www/wp-config.php

wp_user:
  mysql_user.present:
    - name: {{ pillar['wp']['dbname'] }}
    - host: {{ pillar['wp']['dbhost'] }}
    - password: {{ pillar['wp']['dbpass'] }}

wp_db:
  mysql_database.present:
    - name: {{ pillar['wp']['dbname'] }}

wp_grants:
  mysql_grants.present:
    - grant: ALL
    - database: {{ pillar['wp']['dbname'] }}.*
    - user: {{ pillar['wp']['dbuser'] }}

wp_config:
  file.copy:
    - source: /tmp/wordpress/wp-config-sample.php
    - name: /tmp/wordpress/wp-config.php

wp_set_dbname:
  file.sed:
    - name: /tmp/wordpress/wp-config.php
    - before: 'database_name_here'
    - after: '{{ pillar['wp']['dbname'] }}'
    - limit: 'DB_NAME'

wp_set_dbuser:
  file.sed:
    - name: /tmp/wordpress/wp-config.php
    - before: 'username_here'
    - after: '{{ pillar['wp']['dbuser'] }}'
    - limit: 'DB_USER'

wp_set_dbpwd:
  file.sed:
    - name: /tmp/wordpress/wp-config.php
    - before: 'password_here'
    - after: '{{ pillar['wp']['dbpass'] }}'
    - limit: 'DB_PASSWORD'

wp_copy:
  cmd.run:
    - name: 'cp -r /tmp/wordpress/* /var/www/'
    - unless: cat /var/www/wp-config.php

