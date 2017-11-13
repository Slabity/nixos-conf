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


  nix = {
    autoOptimiseStore = true;
    daemonNiceLevel = 1;
    daemonIONiceLevel = 1;
  };

  nixpkgs.config = import ./nixpkgs/config.nix;
  #nixpkgs.config.allowUnfree = true;
}
