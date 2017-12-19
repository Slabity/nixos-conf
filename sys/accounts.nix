{ config, pkgs, expr, sys, ... }:

let
  user = if (sys.user != null) then sys.user else "slabity";
in
{
  security.sudo.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = true;

    extraUsers.${user} = {
      uid = 1000;
      isNormalUser = true;

      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "libvirtd"
      ];

      initialPassword = "temp";
    };
  };
}
