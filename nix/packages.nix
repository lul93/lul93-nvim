{ pkgs }:
with pkgs;
[
  # core tooling
  git
  ripgrep
  fd

  # runtimes
  nodejs_24
  go

  # formatters
  shfmt
  alejandra
  nixfmt
  stylua
  ruff
  nodePackages.prettier

  # language servers
  bash-language-server
  nil
  lua-language-server
  pyright
  mesonlsp
  rust-analyzer

  # build / toolchains
  clang-tools
  meson
  ninja
]
