# Package installed
{% for pset in salt['pillar.get']('chinstrap:pkgs') %}
emerge_{{ pset }}_set:
  file.managed:
    - makedirs: True
    - name: /etc/portage/sets/{{ pset }}
    - contents_pillar: chinstrap:pkgs:{{ pset }}
{% for package in salt['pillar.get']('chinstrap:pkgs:' + pset) %}
install_{{ pset }}_{{ package }}_package:
  pkg.installed:
    - name: {{ package }}
{% endfor %}
{% endfor %}

# Packages to pre-build
{% for pset in salt['pillar.get']('chinstrap:bpkgs') %}
{% for package in salt['pillar.get']('chinstrap:bpkgs:' + pset) %}
install_{{ pset }}_{{ package }}_binpackage:
  pkg.installed:
    - name: {{ package }}
{% endfor %}
{% endfor %}
