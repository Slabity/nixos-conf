{ config, pkgs, expr, sys, ... }:

with builtins; with pkgs.lib; {
  environment.systemPackages = with pkgs; [
    # Version control
    git mercurial subversion

    # Compilers and interpreters
    gcc6 go ghc python36Full nodejs ruby octave
    #rustChannels.nightly.rust
    #rustChannels.nightly.rust-src
  ];

  programs.java.enable = true;
  programs.wireshark.enable = true;
  services.emacs.enable = true;
}
