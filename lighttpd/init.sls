# lighttpd
#
# Meta-state to fully install lighttpd.

include:
  - lighttpd.config
  - lighttpd.service

extend:
  lighttpd_service:
    service:
      - watch:
        - file: lighttpd_config
      - require:
        - file: lighttpd_config
  lighttpd_config:
    file:
      - require:
        - pkg: lighttpd_install
