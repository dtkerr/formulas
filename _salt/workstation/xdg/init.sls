xdg:
  pkg.installed:
    - pkgs:
      - xdg-utils
  file.managed:
    - name: /etc/profile.d/xdg.sh
    - source: salt://{{ slspath }}/xdg.sh
    - mode: 0755
