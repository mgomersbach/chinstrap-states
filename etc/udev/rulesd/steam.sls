steam_udev_rule:
  file.managed:
    - name: /etc/udev/rules.d/70-steam.rules
    - contents: |
        SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
        KERNEL=="uinput", SUBSYSTEM=="misc", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
        KERNEL=="hidraw*", ATTRS{idVendor}=="28de", MODE="0666"
        KERNEL=="hidraw*", KERNELS=="*28DE:*", MODE="0666"
