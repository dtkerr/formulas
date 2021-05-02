tls_certs:
  user.present:
    - name: acme
    - shell: /sbin/nologin
    - home: /var/lib/acme
  cmd.script:
    - source: salt://{{ slspath }}/install_uacme.sh
    - cwd: /var/lib/acme
    - creates: /usr/local/bin/uacme
  file.managed:
    - user: acme
    - group: acme
    - names:
      - /var/lib/acme/dns-01_hook.sh:
        - source: salt://{{ slspath }}/dns-01_hook.sh
        - mode: 0755
      - /var/lib/acme/dns_api_token:
        - source: salt://{{ slspath }}/dns_api_token
        - mode: 0400
        - template: jinja
  pkg.installed:
    - pkgs:
      - jq

tls_certs.acme_dir:
  file.directory:
    - name: /etc/acme
    - user: acme
    - group: acme
    - mode: 0750
  cmd.run:
    - name: /usr/local/bin/uacme --yes --verbose --confdir /etc/acme new terry@oefd.net
    - runas: acme
    - creates: /etc/acme/private/key.pem

tls_certs.allow_nginx_reload:
  file.managed:
    - name: /etc/sudoers.d/acme_can_reload_nginx
    - mode: 0400
    - contents: "acme ALL=(ALL) NOPASSWD: /usr/bin/systemctl reload nginx"
{% for cert in pillar.tls_certs %}
tls_certs.issue {{ cert.domain }}:
  cmd.run:
    - name: |
        uacme --verbose --confdir /etc/acme \
          --hook /var/lib/acme/dns-01_hook.sh \
          --type EC issue {{ cert.domain }} {{ cert.aliases | join(" ") }}
    - runas: acme
    - creates: /etc/acme/{{ cert.domain }}/cert.pem
{% endfor %}

tls_certs.renew_timer:
  file.managed:
    - names:
      - /var/lib/acme/renew.sh:
        - source: salt://{{ slspath }}/renew.sh
        - user: acme
        - group: acme
        - template: jinja
      - /etc/systemd/system/uacme.timer:
        - source: salt://{{ slspath }}/uacme.timer
      - /etc/systemd/system/uacme.service:
        - source: salt://{{ slspath }}/uacme.service
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
      - file: tls_certs.renew_timer
  service.running:
    - name: uacme.timer
    - enable: True
