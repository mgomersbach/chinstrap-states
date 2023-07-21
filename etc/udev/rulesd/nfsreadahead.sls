set_default_nfs_readahead:
  file.managed:
    - name: /etc/udev/rules.d/99-nfs-readahead.rules
    - contents: |
        SUBSYSTEM=="bdi", ACTION=="add", PROGRAM="/bin/awk -v bdi=$kernel 'BEGIN{ret=1} {if ($4 == bdi) {ret=0}} END{exit ret}' /proc/fs/nfsfs/volumes", ATTR{read_ahead_kb}="15380"
