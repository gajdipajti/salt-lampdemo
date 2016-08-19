clear-www:
  file.absent:
{% if grains['osrelease'] == '16.04' %}
    - name: /var/www/html/index.html
{% else %}
    - name: /var/www/index.html
{% endif %}


get_wordpress:
  cmd.run:
    - name: 'wget -O latest.tar.gz http://wordpress.org/latest.tar.gz && tar xzf latest.tar.gz'
    - cwd: /tmp/
{% if grains['osrelease'] == '16.04' %}
    - unless: cat /var/www/html/wp-config.php
{% else %}
    - unless: cat /var/www/wp-config.php
{% endif %}


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
  file.replace:
    - name: /tmp/wordpress/wp-config.php
    - pattern: 'database_name_here'
    - repl: '{{ pillar['wp']['dbname'] }}'

wp_set_dbuser:
  file.replace:
    - name: /tmp/wordpress/wp-config.php
    - pattern: 'username_here'
    - repl: '{{ pillar['wp']['dbuser'] }}'

wp_set_dbpwd:
  file.replace:
    - name: /tmp/wordpress/wp-config.php
    - pattern: 'password_here'
    - repl: '{{ pillar['wp']['dbpass'] }}'

wp_copy:
  cmd.run:
{% if grains['osrelease'] == '16.04' %}
    - name: 'cp -r /tmp/wordpress/* /var/www/html/'
    - unless: cat /var/www/html/wp-config.php
{% else %}
    - name: 'cp -r /tmp/wordpress/* /var/www/'
    - unless: cat /var/www/wp-config.php
{% endif %}
