{
  pkgs ?
    import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
    }) {},
}: let
  plugins = import ./plugins.nix {inherit pkgs;};
  packages = import ./packages.nix {inherit pkgs;};
  nvim = pkgs.wrapNeovim pkgs.neovim-unwrapped {
    configure = {
      customRC = ''
        lua dofile("${toString ../init.lua}")
      '';
      packages.myPlugins.start = plugins;
    };
  };
in
  pkgs.mkShell {
    packages = [nvim] ++ packages;
  }
