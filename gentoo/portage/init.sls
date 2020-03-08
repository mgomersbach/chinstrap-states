{% set firmware = salt['pillar.get']('firmware') %}

# CHOST set
{% if salt['pillar.get']('portage:chost', False) %}
{% if salt['pillar.get']('portage:chost') != salt['makeconf.get_chost']() %}
set_chost:
  module.run:
    - makeconf.set_chost:
      - name: set_chost
      - value: {{ salt['pillar.get']('portage:chost') }}
      - order: 1
{% endif %}
{% endif %}


# CFLAGS set
{% if salt['pillar.get']('portage:cflags:set', False) %}
{% if salt['pillar.get']('portage:cflags:set') != salt['makeconf.get_cflags']() %}
set_cflags:
  module.run:
    - makeconf.set_cflags:
      - name: set_cflags
      - value: {{ salt['pillar.get']('portage:cflags:set') }}
      - order: 1
{% endif %}
{% endif %}


# CFLAGS reset
{% if salt['pillar.get']('portage:cflags:reset', False) %}
{% if salt['makeconf.get_cflags']() != "" %}
reset_cflags:
  module.run:
    - makeconf.set_cflags:
      - name: reset_cflags
      - value: ""
      - order: 2
{% endif %}
{% endif %}


# CFLAGS present
{% for cflag in salt['pillar.get']('portage:cflags:present') %}
{% if not salt['makeconf.cflags_contains'](cflag) %}
present_{{ cflag }}_cflag:
  module.run:
    - makeconf.append_cflags:
      - name: present_{{ cflag }}_cflag
      - value: {{ cflag }}
      - order: 3
{% endif %}
{% endfor %}


# CFLAGS absent
{% for cflag in salt['pillar.get']('portage:cflags:absent') %}
{% if salt['makeconf.cflags_contains'](cflag) %}
absent_{{ cflag }}_cflag:
  module.run:
    - makeconf.trim_cflags:
      - name: absent_{{ cflag }}_cflag
      - value: {{ cflag }}
      - order: 4
{% endif %}
{% endfor %}


# CXXFLAGS set
{% if salt['pillar.get']('portage:cxxflags:set', False) %}
{% if salt['pillar.get']('portage:cxxflags:set') != salt['makeconf.get_cxxflags']() %}
set_cxxflags:
  module.run:
    - makeconf.set_cxxflags:
      - name: set_cxxflags
      - value: {{ salt['pillar.get']('portage:cxxflags:set') }}
      - order: 1
{% endif %}
{% endif %}


# CXXFLAGS reset
{% if salt['pillar.get']('portage:cxxflags:reset', False) %}
{% if salt['makeconf.get_cxxflags']() != "" %}
reset_cxxflags:
  module.run:
    - makeconf.set_cxxflags:
      - name: reset_cxxflags
      - value: ""
      - order: 2
{% endif %}
{% endif %}


# CXXFLAGS present
{% for cxxflag in salt['pillar.get']('portage:cxxflags:present') %}
{% if not salt['makeconf.cxxflags_contains'](cxxflag) %}
present_{{ cxxflag }}_cxxflag:
  module.run:
    - makeconf.append_cxxflags:
      - name: present_{{ cxxflag }}_cxxflag
      - value: {{ cxxflag }}
      - order: 3
{% endif %}
{% endfor %}


# CXXFLAGS absent
{% for cxxflag in salt['pillar.get']('portage:cxxflags:absent') %}
{% if salt['makeconf.cxxflags_contains'](cxxflag) %}
absent_{{ cxxflag }}_cxxflag:
  module.run:
    - makeconf.trim_cxxflags:
      - name: absent_{{ cxxflag }}_cxxflag
      - value: {{ cxxflag }}
      - order: 4
{% endif %}
{% endfor %}


# MAKEOPTS set
{% if salt['pillar.get']('portage:makeopts:set', False) %}
{% if salt['pillar.get']('portage:makeopts:set') != salt['makeconf.get_makeopts']() %}
set_makeopts:
  module.run:
    - makeconf.set_makeopts:
      - name: set_makeopts
      - value: {{ salt['pillar.get']('portage:makeopts:set') }}
      - order: 1
{% endif %}
{% endif %}


# MAKEOPTS reset
{% if salt['pillar.get']('portage:makeopts:reset', False) %}
{% if salt['makeconf.get_makeopts']() != "" %}
reset_makeopts:
  module.run:
    - makeconf.set_makeopts:
      - name: reset_makeopts
      - value: ""
      - order: 2
{% endif %}
{% endif %}


# MAKEOPTS present
{% for makeopt in salt['pillar.get']('portage:makeopts:present') %}
{% if not salt['makeconf.makeopts_contains'](makeopt) %}
present_{{ makeopt }}_makeopt:
  module.run:
    - makeconf.append_makeopts:
      - name: present_{{ makeopt }}_makeopt
      - value: {{ makeopt }}
      - order: 3
{% endif %}
{% endfor %}


# MAKEOPTS absent
{% for makeopt in salt['pillar.get']('portage:makeopts:absent') %}
{% if salt['makeconf.makeopts_contains'](makeopt) %}
absent_{{ makeopt }}_makeopt:
  module.run:
    - makeconf.trim_makeopts:
      - name: absent_{{ makeopt }}_makeopt
      - value: {{ makeopt }}
      - order: 4
{% endif %}
{% endfor %}


# EMERGE_DEFAULT_OPTS set
{% if salt['pillar.get']('portage:emerge_default_opts:set', False) %}
{% if salt['pillar.get']('portage:emerge_default_opts:set') != salt['makeconf.get_emerge_default_opts']() %}
set_emerge_default_opts:
  module.run:
    - makeconf.set_emerge_default_opts:
      - name: set_emerge_default_opts
      - value: {{ salt['pillar.get']('portage:emerge_default_opts:set') }}
      - order: 1
{% endif %}
{% endif %}


# EMERGE_DEFAULT_OPTS reset
{% if salt['pillar.get']('portage:emerge_default_opts:reset', False) %}
{% if salt['makeconf.get_emerge_default_opts']() != "" %}
reset_emerge_default_opts:
  module.run:
    - makeconf.set_emerge_default_opts:
      - name: reset_emerge_default_opts
      - value: ""
      - order: 2
{% endif %}
{% endif %}


# EMERGE_DEFAULT_OPTS present
{% for emerge_opt in salt['pillar.get']('portage:emerge_default_opts:present') %}
{% if not salt['makeconf.emerge_default_opts_contains'](emerge_opt) %}
present_{{ emerge_opt }}_emerge_opt:
  module.run:
    - makeconf.append_emerge_default_opts:
      - name: present_{{ emerge_opt }}_emerge_opt
      - value: {{ emerge_opt }}
      - order: 3
{% endif %}
{% endfor %}


# EMERGE_DEFAULT_OPTS absent
{% for emerge_opt in salt['pillar.get']('portage:emerge_default_opts:absent') %}
{% if salt['makeconf.emerge_default_opts_contains'](emerge_opt) %}
absent_{{ emerge_opt }}_emerge_opt:
  module.run:
    - makeconf.trim_emerge_default_opts:
      - name: absent_{{ emerge_opt }}_emerge_opt
      - value: {{ emerge_opt }}
      - order: 4
{% endif %}
{% endfor %}


# FEATURES set
{% if salt['pillar.get']('portage:features:set', False) %}
{% if salt['pillar.get']('portage:features:set') != salt['makeconf.get_features']() %}
set_features:
  module.run:
    - makeconf.set_features:
      - name: set_features
      - value: {{ salt['pillar.get']('portage:features:set') }}
      - order: 1
{% endif %}
{% endif %}


# FEATURES reset
{% if salt['pillar.get']('portage:features:reset', False) %}
{% if salt['makeconf.get_features']() != "" %}
reset_features:
  module.run:
    - makeconf.set_features:
      - name: reset_features
      - value: ""
      - order: 2
{% endif %}
{% endif %}


# FEATURES present
{% for feature in salt['pillar.get']('portage:features:present') %}
{% if not salt['makeconf.features_contains'](feature) %}
present_{{ feature }}_feature:
  module.run:
    - makeconf.append_features:
      - name: present_{{ feature }}_feature
      - value: {{ feature }}
      - order: 3
{% endif %}
{% endfor %}


# FEATURES absent
{% for feature in salt['pillar.get']('portage:features:absent') %}
{% if salt['makeconf.features_contains'](feature) %}
absent_{{ feature }}_feature:
  module.run:
    - makeconf.trim_features:
      - name: absent_{{ feature }}_feature
      - value: {{ feature }}
      - order: 4
{% endif %}
{% endfor %}


# GENTOO_MIRRORS set
{% if salt['pillar.get']('portage:gentoo_mirrors:set', False) %}
{% if salt['pillar.get']('portage:gentoo_mirrors:set') != salt['makeconf.get_gentoo_mirrors']() %}
set_gentoo_mirrors:
  module.run:
    - makeconf.set_gentoo_mirrors:
      - name: set_gentoo_mirrors
      - value: {{ salt['pillar.get']('portage:gentoo_mirrors:set') }}
      - order: 1
{% endif %}
{% endif %}


# GENTOO_MIRRORS reset
{% if salt['pillar.get']('portage:gentoo_mirrors:reset', False) %}
{% if salt['makeconf.get_gentoo_mirrors']() != "" %}
reset_gentoo_mirrors:
  module.run:
    - makeconf.set_gentoo_mirrors:
      - name: reset_gentoo_mirrors
      - value: ""
      - order: 2
{% endif %}
{% endif %}


# GENTOO_MIRRORS present
{% for mirror in salt['pillar.get']('portage:gentoo_mirrors:present') %}
{% if not salt['makeconf.gentoo_mirrors_contains'](mirror) %}
present_{{ mirror }}_mirror:
  module.run:
    - makeconf.append_gentoo_mirrors:
      - name: present_{{ mirror }}_mirror
      - value: {{ mirror }}
      - order: 3
{% endif %}
{% endfor %}


# GENTOO_MIRRORS absent
{% for mirror in salt['pillar.get']('portage:gentoo_mirrors:absent') %}
{% if salt['makeconf.gentoo_mirrors_contains'](mirror) %}
absent_{{ mirror }}_mirror:
  module.run:
    - makeconf.trim_gentoo_mirrors:
      - name: absent_{{ mirror }}_mirror
      - value: {{ mirror }}
      - order: 4
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
