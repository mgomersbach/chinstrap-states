netifrc-config:
  file.managed:
    - name: /etc/conf.d/net
    - source: salt://gentoo/netifrc/files/net.jinja
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - require:
      - pkg: net-misc/netifrc
      - file: /etc/conf.d/net