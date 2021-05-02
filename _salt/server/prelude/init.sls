prelude:
  pkg.uptodate:
    - refresh: True
  file.absent:
    - names: 
      - /etc/motd
      - /etc/update-motd.d
