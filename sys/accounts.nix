{ config, pkgs, expr, sys, ... }:

{
    security.sudo.enable = true;

    users = {
        defaultUserShell = pkgs.zsh;
        mutableUsers = true;

        extraUsers.tslabinski = {
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
