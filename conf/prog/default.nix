{ config, pkgs, expr, sys, ... }:

with builtins; with pkgs.lib; {
  environment.systemPackages = with pkgs; [
    # Version control
    git mercurial subversion

    nodePackages.tern
    python3Packages.setuptools
    python3Full

    # Documentation
    manpages
  ];

  programs.java.enable = true;
  programs.wireshark.enable = true;
  services.emacs.enable = true;
  services.emacs.defaultEditor = true;
  #  services.emacs.package = expr.emacs;
}
