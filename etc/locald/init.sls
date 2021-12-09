{% for disk in salt['grains.get']('disks', '') %} 
{% if disk.startswith('hd') %}
set_spinning_{{ disk }}_bfq_scheduler_on_boot:
  file.managed:
    - name: /etc/local.d/{{ disk }}_scheduler
    - mode: 644
    - contents:
      - \#!/bin/bash
      - echo "bfq" > /sys/block/{{ disk }}/queue/scheduler
{% endif %}
{% endfor %}

{% for disk in salt['grains.get']('ssds', '') %} 
{% if disk.startswith('sd') %}
set_ssd_{{ disk }}_deadline_scheduler_on_boot:
  file.managed:
    - name: /etc/local.d/{{ disk }}_scheduler
    - mode: 644
    - contents:
      - \#!/bin/bash
      - echo "deadline" > /sys/block/{{ disk }}/queue/scheduler
{% else %}
set_nvme_{{ disk }}_no_scheduler_on_boot:
  file.managed:
    - name: /etc/local.d/{{ disk }}_scheduler
    - mode: 644
    - contents:
      - \#!/bin/bash
      - echo "none" > /sys/block/{{ disk }}/queue/scheduler
{% endif %}
{% endfor %}

set_powersave_on_boot:
  file.managed:
    - name: /etc/local.d/autopowertop
    - mode: 644
    - contents:
      - \#!/bin/bash
      - /usr/sbin/powertop --auto-tune && for i in /sys/bus/usb/devices/*/power/control; do echo on | tee > ${i}; done;
