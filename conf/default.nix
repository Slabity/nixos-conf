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
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];

  networking.nat = {
    enable = true;
    internalInterfaces = ["ve-+"];
    externalInterface = "enp0s25";
  };

  zramSwap.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # List of packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Archiving
    unzip zip unrar

    # Disk and FS
    gptfdisk parted btrfs-progs exfat dosfstools ecryptfs squashfsTools
    linuxPackages.zfs tree

    # Monitoring
    pciutils usbutils atop
    linuxPackages.netatop # Extends atop to add networking
    pstree

    # General utilities
    file bc psmisc

    nix-prefetch-git
    nix-repl
  ];

  virtualisation.libvirtd.enable = true;

  containers.hprapp = {
    privateNetwork = true;
    hostAddress = "192.168.0.2";
    localAddress = "192.168.0.3";
    autoStart = true;

    config = { config, pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
        gcc5
        pkgconfig
        libxmlxx
        # Required until #29570
        glibmm
        openssl
        readline
        boost
        cmake
        autoconf
        gnumake

        # Required if python3 is the default interpretor
        python2
      ];
    };
  };
}
