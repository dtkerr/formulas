bluetooth:
  pkg.installed:
    - pkgs:
      - bluez
  file.managed:
    - name: /etc/bluetooth/main.conf
    - source: salt://{{ slspath }}/main.conf
  service.running:
    - name: bluetooth.service
    - enable: True
    - watch:
      - pkg: bluetooth
      - file: /etc/bluetooth/main.conf
