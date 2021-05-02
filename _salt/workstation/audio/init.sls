audio:
  pkg.installed:
    - pkgs:
      - pulseaudio
      - pulseaudio-alsa
      - pulseaudio-bluetooth
  file.managed:
    - name: /etc/pulse/system.pa
    - source: salt://{{ slspath }}/system.pa
