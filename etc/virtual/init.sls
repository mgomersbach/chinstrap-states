{% if grains['virtual'] == "kvm" or grains['virtual'] == "qemu" %}
install_qemu_guest_agent:
  pkg.installed:
    - name: app-emulation/qemu-guest-agent
  service.running:
    - enable: True
    - name: qemu-guest-agent
    - require:
      - pkg: app-emulation/qemu-guest-agent
{% endif %}

{% if grains['virtual'] == "virtualbox" %}
install_virtualbox_guest_additions:
  pkg.installed:
    - name: app-emulation/virtualbox-guest-additions
  service.running:
    - enable: True
    - name: virtualbox-guest-additions
    - require:
      - pkg: app-emulation/virtualbox-guest-additions
{% endif %}
