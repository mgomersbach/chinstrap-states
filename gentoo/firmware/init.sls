{% set portage = salt['pillar.get']('portage') %}

# File managed
{% if salt['pillar.get']('firmware:automatic', False) %}
{% if salt['pillar.get']('portage:chost') != salt['makeconf.get_chost']() %}
set_chost:
  module.run:
    - order: 1
    - name: makeconf.set_chost
    - makeconf.set_chost:
      value: {{ salt['pillar.get']('portage:chost') }}
{% endif %}
{% endif %}