{ config, pkgs, expr, sys, ... }:

with builtins; with pkgs.lib; {

    imports = [
      ./bootloader.nix
      ./printing.nix
      ./zsh
      ./desktop
      ./prog
    ];

    system.stateVersion = "18.03";
    system.nixosLabel = sys.hostName;

    # Locale
    i18n = {
        consoleFont = "Lat2-Terminus16";
        consoleKeyMap = "us";
        defaultLocale = "en_US.UTF-8";
    };

    time.timeZone = sys.timeZone;
    networking.hostName = sys.hostName;
    networking.networkmanager.enable = true;

    zramSwap.enable = true;
    hardware.opengl.driSupport32Bit = true;

    # List of packages installed in system profile.
    environment.systemPackages = with pkgs; [
        # Archiving
        unzip zip unrar

        # Disk and FS
        gptfdisk parted btrfs-progs exfat dosfstools ecryptfs squashfsTools
        linuxPackages.zfs

        # Monitoring
        pciutils usbutils atop
        linuxPackages.netatop # Extends atop to add networking
    ];

    virtualisation.libvirtd.enable = true;
}
