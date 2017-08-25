{ config, pkgs, expr, sys, ... }:

with builtins; with pkgs.lib; {

    imports = [
        ./bootloader.nix
        ./nixpkgs
        ./desktop
        ./prog
    ];

    system.stateVersion = "17.09";
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

    # Enable CUPS to print documents.
    services.printing.enable = true;

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

        gdb
        pkgconfig
        valgrind
        rustracer

        # Custom packages
        texlive.combined.scheme-full

        zsh-completions
        nix-zsh-completions
    ];

    programs.tmux.enable = true;
    programs.tmux.keyMode = "vi";

    virtualisation.docker.enable = true;
    virtualisation.libvirtd.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        ohMyZsh = {
            enable = true;
            plugins = [
                "common-aliases"
                "compleat"
                "dirhistory"
                "encode64"
                "fasd"
                "git"
                "git-extras"
                "nix"
                "per-directory-history"
                "sudo"
                "systemd"
                "tmux"
                "vi-mode"
                "wd"
            ];
            theme = "../../../../../..${expr.powerlevel9k}/powerlevel9k/powerlevel9k";
        };
    };

    nix = {
        autoOptimiseStore = true;
        daemonNiceLevel = 1;
        daemonIONiceLevel = 1;
    };
}
