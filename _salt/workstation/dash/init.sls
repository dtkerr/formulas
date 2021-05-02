dash:
  pkg.installed:
    - pkgs:
      - dash
  file.managed:
    - name: /etc/profile.d/dash.sh
    - source: salt://{{ slspath }}/dash.sh
    - mode: 0744
