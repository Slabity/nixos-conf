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
    buildCores = 4;
    daemonNiceLevel = 1;
    daemonIONiceLevel = 1;
    gc.automatic = true;
    gc.dates = "00:00";
    maxJobs = 4;
    readOnlyStore = true;
  };

  nixpkgs = import ./nixpkgs;
}
