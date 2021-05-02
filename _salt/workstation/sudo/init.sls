sudo:
  file.managed:
    - name: /etc/sudoers.d/wheel-can-sudo
    - source: salt://{{ slspath }}/wheel-can-sudo
    - mode: 0400
