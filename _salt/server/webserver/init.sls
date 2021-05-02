webserver:
  pkg.installed:
    - pkgs:
      - nginx-light
  file.recurse:
    - name: /etc/nginx
    - source: salt://{{ slspath }}/nginx.d
    - clean: True
  group.present:
    - name: acme
    - addusers:
      - www-data
  service.running:
    - name: nginx.service
    - enable: True
    - reload: True
    - watch:
      - file: /etc/nginx

webserver.deploy_user:
  pkg.installed:
    - pkgs:
      - rsync
  user.present:
    - name: static-deploy
    - fullname: Static Assets Deployment
    - home: /var/static-deploy
    - shell: /bin/sh
  file.directory:
    - name: /srv/http
    - user: static-deploy
    - group: static-deploy
    - mode: 755
  ssh_auth.present:
    - user: static-deploy
    - source: salt://{{ slspath }}/id_static-deploy.pub
