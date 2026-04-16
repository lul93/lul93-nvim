{
  target ? "default",
}:

let
  shells = {
    default = ./nix/shell.nix;
    dev = ./nix/dev.nix;
  };
in
(import shells.${target}) { }
