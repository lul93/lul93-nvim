{pkgs}:
with pkgs; [
  # core
  git
  ripgrep
  fd

  # shell
  shfmt
  bash-language-server

  # nix
  alejandra
  nil

  # lua
  stylua
  lua-language-server

  # python
  ruff
  pyright

  # c / c++
  clang-tools
  meson
  ninja
  mesonlsp

  # rust
  rust-analyzer

  # javascript / typescript
  nodejs
  nodePackages.prettier
  nodePackages.typescript-language-server

  # web
  nodePackages.vscode-langservers-extracted

  # svelte
  nodePackages.svelte-language-server
]
