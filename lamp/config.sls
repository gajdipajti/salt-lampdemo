a2enmod rewrite:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/rewrite.load

a2enmod ssl:
  cmd.run

a2ensite default-ssl:
  cmd.run

apache_token_prod:
  file.replace:
{% if grains['osrelease'] == '12.04' %}
    - name: '/etc/apache2/conf.d/security'
{% else %}
    - name: '/etc/apache2/conf-enabled/security.conf'
{% endif %}
    - pattern: '^ServerTokens\s\w+'
    - repl: 'ServerTokens Prod'

apache_signature_off:
  file.replace:
{% if grains['osrelease'] == '12.04' %}
    - name: '/etc/apache2/conf.d/security'
{% else %}
    - name: '/etc/apache2/conf-enabled/security.conf'
{% endif %}
    - pattern: '^ServerSignature\sOn'
    - repl: 'ServerSignature Off'

apache-restart:
  cmd.run:
    - name: 'service apache2 restart'