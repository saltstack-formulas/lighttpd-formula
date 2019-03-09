# -*- coding: utf-8 -*-
# vim: ft=sls
#
# install lighttpd modules
#
{#- Get the `tplroot` from `tpldir` #}                                                                              
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.install' %}
{%- set sls_config_file = tplroot ~ '.config' %}
{%- set sls_service = tplroot ~ '.service' %}
{% from tplroot ~ "/map.jinja" import lighttpd with context %}
{% set modules = lighttpd.get('modules', {}) %}

## only debian
{% if grains['os_family']=="Debian" %}

include:
  - {{ sls_package_install }}
  - {{ sls_config_file }}
  - {{ sls_service }}

{% for module in modules.get('enabled', []) %}
lighty-enable-mod {{ module }}:
  cmd.run:
    - unless: ls {{ lighttpd.conf_enabled }}/??-{{ module }}.conf
    - order: 225
    - require:
      - pkg: lighttpd_install
    - watch_in:
      - module: lighttpd-restart
{% endfor %}

{% for module in modules.get('disabled', []) %}
lighty-disable-mod {{ module }}:
  cmd.run:
    - onlyif: ls {{ lighttpd.conf_enabled }}/??-{{ module }}.conf
    - order: 225
    - require:
      - pkg: lighttpd_install
    - watch_in:
      - module: lighttpd-restart
{% endfor %}

{% endif %}
