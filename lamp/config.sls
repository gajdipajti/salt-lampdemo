a2enmod rewrite:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/rewrite.load

a2enmod ssl:
  cmd.run

a2ensite default-ssl:
  cmd.run

apache_token_prod:
  file.sed:
    - name: '/etc/apache2/conf.d/security'
    - before: 'OS'
    - after: 'Prod'
    - limit: '^ServerTokens'

apache_signature_off:
  file.sed:
    - name: '/etc/apache2/conf.d/security'
    - before: 'On'
    - after: 'Off'
    - limit: '^ServerSignature'

apache-restart:
  cmd.run:
    - name: 'service apache2 restart'