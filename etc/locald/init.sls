set_powersave_on_boot:
  file.managed:
    - name: /etc/local.d/autopowertop
    - mode: 544
    - contents: |
        #!/bin/bash
        /usr/sbin/powertop --auto-tune && for i in /sys/bus/usb/devices/*/power/control; do echo on | tee > ${i}; done;
