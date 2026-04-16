{
  config,
  pkgs,
  topology,
  neovim-custom,
  ...
}:
let
  # use unstable packages
  plugins = import ./plugins.nix { inherit pkgs; };
  packages = import ./packages.nix { inherit pkgs; };
in
{
  # Use an out-of-store symlink so the Neovim config stays editable without
  # rebuilding Home Manager. This links ~/.config/nvim directly to the repo
  # directory instead of copying it into the Nix store. Convenient for active
  # development, but not strictly reproducible.

  # xdg.configFile."nvim".source =
  #   config.lib.file.mkOutOfStoreSymlink
  #   topology.homeModules.nvim.path;

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink /home/d4t4/nixos/modules/home/nvim;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    package = neovim-custom;

    extraPackages = packages;

    plugins = plugins;
  };
}
