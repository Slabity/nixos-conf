{ config, pkgs, ... }:
{
  imports = [
    ./sys/hardware-configuration.nix
    ./sys/accounts.nix
    ./conf
  ];

  _module.args.expr = import ./expr { inherit pkgs; };
  _module.args.sys = import ./sys;
  _module.args.buildVM = false;

  nix = import ./nix {
    sockets = 1;
    cores = 4;
    threads = 1;
    responsive = true;
  };

  nixpkgs = import ./nixpkgs {
    mozilla.enable = true;
    custom.enable = true;
  };
}
