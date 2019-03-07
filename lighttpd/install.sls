# -*- coding: utf-8 -*-
# vim: ft=sls
#
# lighttpd.install
#
# Manages installation of lighttpd.

{%- set tplroot = tpldir.split('/')[0] %}
{% from tplroot ~ '/map.jinja' import lighttpd with context %}

lighttpd_install:
  pkg.installed:
    - name: {{ lighttpd.package }}

lighttpd_extra_install:
  pkg.installed:
    - pkgs: {{ lighttpd.extra_packages | json }}
