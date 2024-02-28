netifrc-pkg:
  pkg.installed:
    - name: net-misc/netifrc

netifrc-config:
  file.managed:
    - name: /etc/conf.d/net
    - source: salt://gentoo/netifrc/files/net.jinja
    - template: jinja
    - mode: 644
    - user: root
    - group: root
