{ config, pkgs, ... }:

{
    imports = [
          ./sys/hardware-configuration.nix
          ./conf
      ];

    nixpkgs.config = import ./conf/nixpkgs.nix;
    _module.args.expr = import ./expr { inherit pkgs; };
    _module.args.sys = import ./sys;
    _module.args.buildVM = false;
}
