{ pkgs ? import <nixpkgs> {} }: with pkgs;

rec {
    powerlevel9k = callPackage ./powerlevel9k {};
}