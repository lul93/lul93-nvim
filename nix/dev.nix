{
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  }) { },
}:
let
  plugins = import ./plugins_dev.nix { inherit pkgs; };
  packages = import ./packages_dev.nix { inherit pkgs; };
  nvim = pkgs.wrapNeovim pkgs.neovim-unwrapped {
    configure = {
      customRC = ''
        lua dofile(vim.fn.getcwd() .. "/dev/nvim/init.lua")
      '';
      packages.myPlugins.start = plugins;
    };
  };

in
pkgs.mkShell {
  packages = [ nvim ] ++ packages;
  shellHook = ''
    export XDG_CONFIG_HOME=$PWD/dev/
    export XDG_DATA_HOME=$PWD/dev/.nvim-data
    export XDG_CACHE_HOME=$PWD/dev/.nvim-cache
  '';
}
