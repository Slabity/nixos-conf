{ config, pkgs, expr, sys, ... }:

let
    efiDir = if builtins.hasAttr "efiPath" sys then sys.efiPath else "/boot";
in
{
    boot = {
        loader = {
            efi.efiSysMountPoint = efiDir;
            efi.canTouchEfiVariables = true;
            grub = {
                enable = true;
                device = "nodev";
                enableCryptodisk = true;
                efiSupport = true;
                useOSProber = true;
                configurationName = sys.hostName;
            };
            timeout = 3;
        };
    };
}
