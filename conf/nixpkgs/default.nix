{ config, pkgs, expr, sys, ... }:

with builtins; with pkgs.lib; {
    # Allow proprietary software
    nixpkgs.config.allowUnfree = true;

    nix.binaryCaches = [ "https://cache.nixos.org" "https://nixcache.reflex-frp.org" ];
    nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
}