{ config, pkgs, expr, sys, ... }:

with builtins; with pkgs.lib; {
  services.printing.enable = sys.printing;
  services.printing.drivers = with pkgs; [
    gutenprint
    gutenprintBin
    cupsBjnp
    mfcj470dw-cupswrapper
    mfcj6510dw-cupswrapper
    mfcl2700dncupswrapper
  ];
}
