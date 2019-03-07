# -*- coding: utf-8 -*-
# vim: ft=sls
#
# lighttpd.service
#
# Manages the lighttpd service.

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config' %}
{%- from tplroot ~ '/map.jinja' import lighttpd with context %}

include:
  - {{ sls_config_file }}
  
lighttpd_service:
  service.running:
    - name: {{ lighttpd.service }}
    - enable: True
    - require:
      - sls: {{ sls_config_file }}
    - watch:
      - file: lighttpd_config

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
