g815_udev_rule:
  file.managed:
    - name: /etc/udev/rules.d/70-g815.rules
    - contents: |
        ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c33f", MODE="666" RUN+="/usr/bin/g815-led -p /etc/g810-led/profile"