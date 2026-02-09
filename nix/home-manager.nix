{
  config,
  pkgs,
  ...
}: let
  # use unstable packages
  plugins = import ./plugins.nix {inherit pkgs;};
  packages = import ./packages.nix {inherit pkgs;};
in {
  # keep config outside the Nix store so editing Lua files
  # does not require rebuilding the Home-Manager generation
  # (development convenience, not reproducible)
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/home-manager/nvim";

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = packages;

    plugins = plugins;
  };
}
