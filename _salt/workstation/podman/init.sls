podman:
  pkg.installed:
    - pkgs:
      - podman
  file.managed:
    - names:
      - /etc/subuid:
        - contents: |
            terry:10000:65536
      - /etc/subgid:
        - contents: |
            terry:10000:65536
