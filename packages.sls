terminal-tools:
  pkg.installed:
    - names:
    - mc
    - htop
    - screen
    - ssh
    - xz-utils
    - iptraf
    - iftop
    - iotop
    - fail2ban
    - molly-guard
    - elinks
    - wget
    - git
    - p7zip-full
    - python-software-properties
    - finger
    - lvm2
{% if grains['osrelease'] == '14.04' %}
    - glances
{% endif %}