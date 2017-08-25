{ config, pkgs, expr, sys, ... }:

with builtins; with pkgs.lib; {
    # Allow proprietary software
    nixpkgs.config.allowUnfree = true;

    imports = [
        ./mozilla.nix
    ];
}
