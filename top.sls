base:
  '*':
    - timezone
    - etc.skel
    - sysctl.param
    - users
    - openssh
    - openssh.banner
    - openssh.config
    - openssh.known_hosts
    - resolver
    - gentoo.portage
    - etc.fstab
  'G@virtual:physical':
    - match: compound
    - grub
  'eselect:profile:chinstrap*':
    - match: grain
    - genkernel.config
    - packages.chinstrap
    - iptables
    - chrony
    - chrony.config
    - postfix
    - postfix.config
    - rsyslog
  'G@cpu_flags:rdrand and G@eselect:profile:chinstrap*':
    - match: compound
    - rng-tools
  'eselect:profile:chinstrap*server':
    - match: grain
    - nginx
    - php
    - php.fpm
    - php.apcu
    - php.curl
    - php.gd
    - php.mcrypt
    - php.mysql
    - php.xml
    - php.json
  'eselect:profile:chinstrap*buildhelper':
    - match: grain
    - nginx
    - php
    - php.fpm
    - php.apcu
    - php.curl
    - php.gd
    - php.mcrypt
    - php.mysql
    - php.xml
    - php.json
  'eselect:profile:chinstrap*desktop':
    - match: grain
    - lightdm.config
  'eselect:profile:chinstrap*markws':
    - match: grain
    - lightdm.config
    - nginx
    - php
    - php.fpm
    - php.apcu
    - php.curl
    - php.gd
    - php.mcrypt
    - php.mysql
    - php.xml
    - php.json
