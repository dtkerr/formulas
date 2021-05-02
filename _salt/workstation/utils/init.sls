utils:
  pkg.installed:
    - pkgs:
      - bind
      - fish
      - fzf
      - git
      - httpie
      - neovim
      - openssh
      - ripgrep
  file.symlink:
    - name: /usr/bin/vi
    - target: /usr/bin/nvim
