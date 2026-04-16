{ pkgs }:
with pkgs;
[
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
  nixfmt

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
]
