{ config, pkgs, expr, sys, ... }:

with builtins; with pkgs.lib; {
  environment.systemPackages = with pkgs; [
    # Version control
    git mercurial subversion

    # Compilers and interpreters
    gcc6 go python36Full nodejs ruby octave
  ];

  programs.java.enable = true;
  programs.wireshark.enable = true;
  services.emacs.enable = true;
  services.emacs.defaultEditor = true;
}
