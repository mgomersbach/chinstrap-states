set_default_io_schedulers:
  file.managed:
    - name: /etc/udev/rules.d/99-default-io-scheduler.rules
    - contents: |
        KERNEL=="nvme[0-9]*n[0-9]*", ENV{DEVTYPE}=="disk", ATTR{queue/scheduler}="deadline", ATTR{queue/rotational}=="0", ATTR{bdi/read_ahead_kb}="64"
        SUBSYSTEM=="block", ATTR{queue/rotational}=="0", ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{bdi/read_ahead_kb}="2048", ATTR{queue/scheduler}="deadline"
        SUBSYSTEM=="block", ATTR{queue/rotational}=="1", ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{bdi/read_ahead_kb}="2048", ATTR{queue/scheduler}="bfq"
