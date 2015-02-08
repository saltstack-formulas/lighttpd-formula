# lighttpd.service
#
# Manages the lighttpd service.

{% from 'lighttpd/map.jinja' import lighttpd with context %}

include:
  - lighttpd.install
  
lighttpd_service:
  service.running:
    - name: {{ lighttpd.service }}
    - require:
      - sls: lighttpd.install
    - watch:
      - pkg: lighttpd_install
