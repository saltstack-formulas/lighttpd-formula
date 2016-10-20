{% if grains['os_family']=="Debian" %}

include:
  - lighttpd

{% for module in salt['pillar.get']('lighttpd:modules:enabled', []) %}
lighty-enable-mod {{ module }}:
  cmd.run:
    - unless: ls /etc/lighttpd/conf-enabled/??-{{ module }}.conf
    - order: 225
    - require:
      - pkg: lighttpd
    - watch_in:
      - module: lighttpd-restart
{% endfor %}

{% for module in salt['pillar.get']('lighttpd:modules:disabled', []) %}
lighty-disable-mod {{ module }}:
  cmd.run:
    - onlyif: ls /etc/lighttpd/conf-enabled/??-{{ module }}.conf
    - order: 225
    - require:
      - pkg: lighttpd
    - watch_in:
      - module: lighttpd-restart
{% endfor %}

{% endif %}
