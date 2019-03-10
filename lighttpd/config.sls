# lighttpd.config
#
# Manages the main lighttpd server configuration file.

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.install' %}
{% from tplroot ~ "/map.jinja" import lighttpd with context %}
{% from tplroot ~ "/macros.jinja" import files_switch with context -%}
{% set file = lighttpd.get('config', ['lighttpd.conf']) %}

include:
  - {{ sls_package_install }}

lighttpd_config:
  file.managed:
    - name: /etc/lighttpd/{{ lighttpd.config }}
    - source: {{ files_switch(
                      salt['config.get'](
                        tplroot ~ ':tofs:source_files:lighttpd_config',
                        ['/etc/lighttpd/lighttpd.conf', '/etc/lighttpd/lighttpd.conf.jinja']
                      )
              ) }}
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
