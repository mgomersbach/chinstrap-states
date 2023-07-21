osvrhdk_udev_rule:
  file.managed:
    - name: /etc/udev/rules.d/70-osvrhdk.rules
    - contents: |
        SUBSYSTEM=="usb", ATTRS{idVendor}=="1532", ATTRS{idProduct}=="0b00", MODE="0660", GROUP="plugdev"
        KERNEL=="hidraw*", ATTRS{busnum}=="1", ATTRS{idVendor}=="1532", ATTRS{idProduct}=="0b00", MODE="0660", GROUP="plugdev"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="1532", ATTRS{idProduct}=="0b00", ENV{ID_MM_DEVICE_IGNORE}="1"
        SUBSYSTEM=="tty", ATTRS{idVendor}=="1532", ATTRS{idProduct}=="0b00", SYMLINK+="ttyUSB.OSVRHDK"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0515", ENV{ID_MM_DEVICE_IGNORE}="1"
        SUBSYSTEM=="tty", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0515", SYMLINK+="ttyUSB.zSight"
