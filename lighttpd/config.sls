# lighttpd.config
#
# Manages the main lighttpd server configuration file.

{% from "lighttpd/map.jinja" import lighttpd with context %}
{% from "lighttpd/macros.jinja" import files_switch with context -%}
{% set file = lighttpd.get('config', ['lighttpd.conf']) %}


lighttpd_config:
  file.managed:
    - name: /etc/lighttpd/{{ lighttpd.config }}
    - source: {{ files_switch('lighttpd', ['/etc/lighttpd/' ~ file,
                                           '/etc/lighttpd/' ~ file ~ '.jinja']) }}
    - template: jinja
