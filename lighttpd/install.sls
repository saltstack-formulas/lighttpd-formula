# lighttpd.install
#
# Manages installation of lighttpd.

{% from 'lighttpd/map.jinja' import lighttpd with context %}

lighttpd_install:
  pkg.installed:
    - name: {{ lighttpd.package }}
