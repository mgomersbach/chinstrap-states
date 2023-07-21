# Setup mesh

{% for mesh in salt['pillar.get']('wgquickmesh:meshes') %}
wgquickmesh_{{ mesh }}:
  file.managed:
    - makedirs: True
    - name: /etc/wireguard/{{ mesh }}.conf
    - contents_pillar: wgquickmesh:meshes:{{ mesh }}
{% for peer in salt['pillar.get']('wgquickmesh:meshes:' + mesh) %}
install_{{ pset }}_{{ package }}_package:
  pkg.installed:
    - name: {{ package }}
{% endfor %}
{% endfor %}