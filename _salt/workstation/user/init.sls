user:
  user.present:
    - name: terry
    - fullname: Terry Kerr
    - shell: /bin/dash
    - groups:
      - wheel
      - rfkill
    - optional_groups:
      - docker
      - wireshark
    - remove_groups: False
    - password: {{ pillar.user.password }}
  file.directory:
    - user: terry
    - group: terry
    - names:
      - /home/terry/documents
      - /home/terry/downloads
      - /home/terry/images
      - /home/terry/.local/bin

user.config:
  file.recurse:
    - user: terry
    - group: terry
    - template: jinja
    - name: /home/terry/.config
    - source: salt://{{ slspath }}/config

user.top_level_config:
  file.managed:
    - user: terry
    - group: terry
    - template: jinja
    - names:
      - /home/terry/.editorconfig:
        - source: salt://{{ slspath }}/editorconfig
      - /home/terry/.gitconfig:
        - source: salt://{{ slspath }}/gitconfig

user.editor:
  pkg.installed:
    - pkgs:
      - neovim
      - fzf
      - nodejs
      - npm
      - yarn
      - deno
      - rust-analyzer
      - python
      - python-black

desktop:
  pkg.installed:
    - pkgs:
      # desktop functionality
      - blueman
      - gtk2
      - light
      - nm-connection-editor
      - pavucontrol
      - rofi
      - sway
      - swayidle
      - swaylock
      - waybar
      - wl-clipboard
      - xorg-xwayland
      - pipewire
      - ibus

      # utilities
      - alacritty
      - chromium
      - broot

      # fonts
      - noto-fonts
      - noto-fonts-cjk
      - noto-fonts-emoji
      - ttf-bitstream-vera
      - ttf-fira-mono
      - ttf-fira-sans
      - ttf-ibm-plex
      - ttf-liberation
      - ttf-nerd-fonts-symbols-mono
      - ttf-roboto
