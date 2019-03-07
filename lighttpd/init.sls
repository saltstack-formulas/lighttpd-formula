# -*- coding: utf-8 -*-
# vim: ft=sls
#
# lighttpd
#
# Meta-state to fully install lighttpd.

include:
  - .config
  - .service

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
