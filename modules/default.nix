{ pkgs, ... }:
{
  imports = [
    ./lib
    ./system.nix
    ./hardware.nix
    ./passwd.nix
    ./nix.nix
    ./profiles
    ./zsh
    ./emacs
    ./i3
  ];

  environment.systemPackages = with pkgs; [
    nix-index
    nix-prefetch-git
    nix-repl

    unzip zip unrar

    pciutils usbutils atop
    pstree

    file bc psmisc

    git manpages
  ];
}
