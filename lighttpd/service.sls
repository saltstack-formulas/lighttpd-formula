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

# The following states are inert by default and can be used by other states to
# trigger a restart or reload as needed.
lighttpd-reload:
  module.wait:
    - name: service.reload
    - m_name: {{ lighttpd.service }}

lighttpd-restart:
  module.wait:
    - name: service.restart
    - m_name: {{ lighttpd.service }}
