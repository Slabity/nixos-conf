{ config, pkgs, expr, sys, ... }:

let
    mozillaPkgsDir = (import <nixpkgs>{config={};}).fetchFromGitHub {
        owner = "slabity";
        repo = "nixpkgs-mozilla";
        rev = "HEAD";
        sha256 = "0idhapf4c41mj8lvrca2x4dfw8v68iw98vzd9hsdrd6b474j32pj";
        fetchSubmodules = true;
    };
in
with builtins; with pkgs.lib; {
    nixpkgs.overlays = [
        (import "${mozillaPkgsDir}/rust-overlay.nix")
        (import "${mozillaPkgsDir}/firefox-overlay.nix")
    ];
}
