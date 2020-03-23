{% set firmware = salt['pillar.get']('firmware') %}

# CHOST set
{% if salt['pillar.get']('portage:chost', False) %}
{% if salt['pillar.get']('portage:chost') != salt['makeconf.get_chost']() %}
set_chost:
  module.run:
    - order: 1
    - makeconf.set_chost:
      - value: {{ salt['pillar.get']('portage:chost') }}
{% endif %}
{% endif %}


# CFLAGS set
{% if salt['pillar.get']('portage:cflags:set', False) %}
{% if salt['pillar.get']('portage:cflags:set') != salt['makeconf.get_cflags']() %}
set_cflags:
  module.run:
    - order: 1
    - makeconf.set_cflags:
      - value: {{ salt['pillar.get']('portage:cflags:set') }}
{% endif %}
{% endif %}


# CFLAGS reset
{% if salt['pillar.get']('portage:cflags:reset', False) %}
{% if salt['makeconf.get_cflags']() != "" %}
reset_cflags:
  module.run:
    - order: 2
    - makeconf.set_cflags:
      - value: ""
{% endif %}
{% endif %}


# CFLAGS present
{% for cflag in salt['pillar.get']('portage:cflags:present') %}
{% if not salt['makeconf.cflags_contains'](cflag) %}
present_{{ cflag }}_cflag:
  module.run:
    - order: 3
    - makeconf.append_cflags:
      - value: {{ cflag }}
{% endif %}
{% endfor %}


# CFLAGS absent
{% for cflag in salt['pillar.get']('portage:cflags:absent') %}
{% if salt['makeconf.cflags_contains'](cflag) %}
absent_{{ cflag }}_cflag:
  module.run:
    - order: 4
    - makeconf.trim_cflags:
      - value: {{ cflag }}
{% endif %}
{% endfor %}


# CXXFLAGS set
{% if salt['pillar.get']('portage:cxxflags:set', False) %}
{% if salt['pillar.get']('portage:cxxflags:set') != salt['makeconf.get_cxxflags']() %}
set_cxxflags:
  module.run:
    - order: 1
    - makeconf.set_cxxflags:
      - value: {{ salt['pillar.get']('portage:cxxflags:set') }}
{% endif %}
{% endif %}


# CXXFLAGS reset
{% if salt['pillar.get']('portage:cxxflags:reset', False) %}
{% if salt['makeconf.get_cxxflags']() != "" %}
reset_cxxflags:
  module.run:
    - order: 2
    - makeconf.set_cxxflags:
      - value: ""
{% endif %}
{% endif %}


# CXXFLAGS present
{% for cxxflag in salt['pillar.get']('portage:cxxflags:present') %}
{% if not salt['makeconf.cxxflags_contains'](cxxflag) %}
present_{{ cxxflag }}_cxxflag:
  module.run:
    - order: 3
    - makeconf.append_cxxflags:
      - value: {{ cxxflag }}
{% endif %}
{% endfor %}


# CXXFLAGS absent
{% for cxxflag in salt['pillar.get']('portage:cxxflags:absent') %}
{% if salt['makeconf.cxxflags_contains'](cxxflag) %}
absent_{{ cxxflag }}_cxxflag:
  module.run:
    - order: 4
    - makeconf.trim_cxxflags:
      - value: {{ cxxflag }}
{% endif %}
{% endfor %}


# MAKEOPTS set
{% if salt['pillar.get']('portage:makeopts:set', False) %}
{% if salt['pillar.get']('portage:makeopts:set') != salt['makeconf.get_makeopts']() %}
set_makeopts:
  module.run:
    - order: 1
    - makeconf.set_makeopts:
      - value: {{ salt['pillar.get']('portage:makeopts:set') }}
{% endif %}
{% endif %}


# MAKEOPTS reset
{% if salt['pillar.get']('portage:makeopts:reset', False) %}
{% if salt['makeconf.get_makeopts']() != "" %}
reset_makeopts:
  module.run:
    - order: 2
    - makeconf.set_makeopts:
      - value: ""
{% endif %}
{% endif %}


# MAKEOPTS present
{% for makeopt in salt['pillar.get']('portage:makeopts:present') %}
{% if not salt['makeconf.makeopts_contains'](makeopt) %}
present_{{ makeopt }}_makeopt:
  module.run:
    - order: 3
    - makeconf.append_makeopts:
      - value: {{ makeopt }}
{% endif %}
{% endfor %}


# MAKEOPTS absent
{% for makeopt in salt['pillar.get']('portage:makeopts:absent') %}
{% if salt['makeconf.makeopts_contains'](makeopt) %}
absent_{{ makeopt }}_makeopt:
  module.run:
    - order: 4
    - makeconf.trim_makeopts:
      - value: {{ makeopt }}
{% endif %}
{% endfor %}


# EMERGE_DEFAULT_OPTS set
{% if salt['pillar.get']('portage:emerge_default_opts:set', False) %}
{% if salt['pillar.get']('portage:emerge_default_opts:set') != salt['makeconf.get_emerge_default_opts']() %}
set_emerge_default_opts:
  module.run:
    - order: 1
    - makeconf.set_emerge_default_opts:
      - value: {{ salt['pillar.get']('portage:emerge_default_opts:set') }}
{% endif %}
{% endif %}


# EMERGE_DEFAULT_OPTS reset
{% if salt['pillar.get']('portage:emerge_default_opts:reset', False) %}
{% if salt['makeconf.get_emerge_default_opts']() != "" %}
reset_emerge_default_opts:
  module.run:
    - order: 2
    - makeconf.set_emerge_default_opts:
      - value: ""
{% endif %}
{% endif %}


# EMERGE_DEFAULT_OPTS present
{% for emerge_opt in salt['pillar.get']('portage:emerge_default_opts:present') %}
{% if not salt['makeconf.emerge_default_opts_contains'](emerge_opt) %}
present_{{ emerge_opt }}_emerge_opt:
  module.run:
    - order: 3
    - makeconf.append_emerge_default_opts:
      - value: {{ emerge_opt }}
{% endif %}
{% endfor %}


# EMERGE_DEFAULT_OPTS absent
{% for emerge_opt in salt['pillar.get']('portage:emerge_default_opts:absent') %}
{% if salt['makeconf.emerge_default_opts_contains'](emerge_opt) %}
absent_{{ emerge_opt }}_emerge_opt:
  module.run:
    - order: 4
    - makeconf.trim_emerge_default_opts:
      - value: {{ emerge_opt }}
{% endif %}
{% endfor %}


# FEATURES set
{% if salt['pillar.get']('portage:features:set', False) %}
{% if salt['pillar.get']('portage:features:set') != salt['makeconf.get_features']() %}
set_features:
  module.run:
    - order: 1
    - makeconf.set_features:
      - value: {{ salt['pillar.get']('portage:features:set') }}
{% endif %}
{% endif %}


# FEATURES reset
{% if salt['pillar.get']('portage:features:reset', False) %}
{% if salt['makeconf.get_features']() != "" %}
reset_features:
  module.run:
    - order: 2
    - makeconf.set_features:
      - value: ""
{% endif %}
{% endif %}


# FEATURES present
{% for feature in salt['pillar.get']('portage:features:present') %}
{% if not salt['makeconf.features_contains'](feature) %}
present_{{ feature }}_feature:
  module.run:
    - order: 3
    - makeconf.append_features:
      - value: {{ feature }}
{% endif %}
{% endfor %}


# FEATURES absent
{% for feature in salt['pillar.get']('portage:features:absent') %}
{% if salt['makeconf.features_contains'](feature) %}
absent_{{ feature }}_feature:
  module.run:
    - order: 4
    - makeconf.trim_features:
      - value: {{ feature }}
{% endif %}
{% endfor %}


# GENTOO_MIRRORS set
{% if salt['pillar.get']('portage:gentoo_mirrors:set', False) %}
{% if salt['pillar.get']('portage:gentoo_mirrors:set') != salt['makeconf.get_gentoo_mirrors']() %}
set_gentoo_mirrors:
  module.run:
    - order: 1
    - makeconf.set_gentoo_mirrors:
      - value: {{ salt['pillar.get']('portage:gentoo_mirrors:set') }}
{% endif %}
{% endif %}


# GENTOO_MIRRORS reset
{% if salt['pillar.get']('portage:gentoo_mirrors:reset', False) %}
{% if salt['makeconf.get_gentoo_mirrors']() != "" %}
reset_gentoo_mirrors:
  module.run:
    - order: 2
    - makeconf.set_gentoo_mirrors:
      - value: ""
{% endif %}
{% endif %}


# GENTOO_MIRRORS present
{% for mirror in salt['pillar.get']('portage:gentoo_mirrors:present') %}
{% if not salt['makeconf.gentoo_mirrors_contains'](mirror) %}
present_{{ mirror }}_mirror:
  module.run:
    - order: 3
    - makeconf.append_gentoo_mirrors:
      - value: {{ mirror }}
{% endif %}
{% endfor %}


# GENTOO_MIRRORS absent
{% for mirror in salt['pillar.get']('portage:gentoo_mirrors:absent') %}
{% if salt['makeconf.gentoo_mirrors_contains'](mirror) %}
absent_{{ mirror }}_mirror:
  module.run:
    - order: 4
    - makeconf.trim_gentoo_mirrors:
      - value: {{ mirror }}
{% endif %}
{% endfor %}


# EXTRA_VARS
{% for var in salt['pillar.get']('portage:extra_vars') %}

{% set setval = salt['pillar.get']('portage:extra_vars:' + var + ':set') %}
{% set resetval = salt['pillar.get']('portage:extra_vars:' + var + ':reset') %}

# Set
{% if salt['pillar.get']('portage:extra_vars:' + var + ':set', False) %}
{% if setval != salt['makeconf.get_var'](var.upper()) %}
set_{{ var }}_extra_vars:
  module.run:
    - makeconf.set_var:
      - name: set_{{ var }}_extra_vars
      - var: {{ var.upper() }}
      - value: {{ setval }}
      - order: 5
{% endif %}
{% endif %}

# Reset
{% if resetval == True %}
reset_{{ var }}_extra_vars:
  module.run:
    - makeconf.set_var:
      - name: reset_{{ var }}_extra_vars
      - var: {{ var.upper() }}
      - value: ""
      - order: 6
{% endif %}

# Present
{% for val in salt['pillar.get']('portage:extra_vars:' + var + ':present') %}
{% if not salt['makeconf.var_contains'](var.upper(), val) %}
present_{{ var }}_{{ val }}_extra_vars:
  module.run:
    - makeconf.append_var:
      - name: present_{{ var }}_{{ val }}_extra_vars
      - var: {{ var.upper() }}
      - value: {{ val }}
      - order: 7
{% endif %}
{% endfor %}

# Absent
{% for val in salt['pillar.get']('portage:extra_vars:' + var + ':absent') %}
{% if salt['makeconf.var_contains'](var.upper(), val) %}
absent_{{ var }}_{{ val }}_extra_vars:
  module.run:
    - makeconf.trim_var:
      - name: absent_{{ var }}_{{ val }}_extra_vars
      - var: {{ var.upper() }}
      - value: {{ val }}
      - order: 8
{% endif %}
{% endfor %}

{% endfor %}
