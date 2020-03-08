zshrc:
  file.managed:
    - name: /etc/skel/.zshrc
    - source: salt://etc/skel/files/zshrc
    - onlyif:
      - ls /var/db/pkg/app-shells/zsh-*

oh-my-zsh:
  file.symlink:
    - name: /etc/skel/.oh-my-zsh
    - target: /usr/share/zsh/site-contrib/oh-my-zsh
    - onlyif:
      - ls /var/db/pkg/app-shells/oh-my-zsh-*

Xresources:
  file.managed:
    - name: /etc/skel/.Xresources
    - source: salt://etc/skel/files/Xresources
    - onlyif:
      - ls /var/db/pkg/x11-base/xorg-server-*

