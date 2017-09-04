{ config, pkgs, expr, sys, ... }:

let
    mozillaPkgsDir = (import <nixpkgs>{config={};}).fetchFromGitHub {
        owner = "mozilla";
        repo = "nixpkgs-mozilla";
        rev = "HEAD";
        sha256 = "1shz56l19kgk05p2xvhb7jg1whhfjix6njx1q4rvrc5p1lvyvizd";
        fetchSubmodules = true;
    };
in
with builtins; with pkgs.lib; {
    nixpkgs.overlays = [
        (import "${mozillaPkgsDir}/rust-overlay.nix")
        (import "${mozillaPkgsDir}/firefox-overlay.nix")
    ];
}
