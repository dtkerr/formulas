pacman:
  file.managed:
    - names:
      - /etc/pacman.conf:
        - source: salt://{{ slspath }}/pacman.conf
      - /etc/pacman.d/mirrorlist:
        - source: salt://{{ slspath }}/mirrorlist
      - /etc/pacman.d/hooks/100-systemd-boot.hook:
        - makedirs: True
        - source: salt://{{ slspath }}/systemd-boot.hook
