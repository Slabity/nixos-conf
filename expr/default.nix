{ pkgs ? import <nixpkgs> {} }: with pkgs;

rec {
    powerlevel9k = callPackage ./powerlevel9k {};

    acsOverride = {
        name = "acs-override";
        patch = ./patches/override_for_missing_acs_capabilities.patch;
    };
}