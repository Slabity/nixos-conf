{ config, pkgs, expr, sys, ... }:

{
    security.sudo.enable = true;

    users = {
        defaultUserShell = pkgs.zsh;
        mutableUsers = false;

        extraUsers.slabity = {
            uid = 1000;
            isNormalUser = true;

            extraGroups = [
                "wheel"
                "networkmanager"
                "docker"
                "libvirtd"
            ];

            passwordFile = "${./passwd}";
        };
    };
}
