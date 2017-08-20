{ config, pkgs, expr, sys, ... }:

with builtins; with pkgs.lib; {

    imports = [
        ./bootloader.nix
        ./desktop
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

    # Create an actual user.
    users.defaultUserShell = pkgs.zsh;
    users.extraUsers.slabity = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "networkmanager"
            "docker"
            "libvirtd"
        ];
        uid = 1000;
    };

    zramSwap.enable = true;

    hardware.opengl.driSupport32Bit = true;

    # List of packages installed in system profile.
    environment.systemPackages = with pkgs; [
        # Version control
        git mercurial subversion

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
        gcc6
        valgrind
        go
        ghc                 # Haskell compiler
        python36Full
        #rustChannels.nightly.rust
        #rustChannels.nightly.rust-src
        rustracer

        # Custom packages
        texlive.combined.scheme-full
    ];

    services.emacs.enable = true;
    programs.tmux.enable = true;
    programs.tmux.keyMode = "vi";

    virtualisation.docker.enable = true;
    virtualisation.libvirtd.enable = true;

    programs.zsh = {
        enable = true;
        ohMyZsh = {
            enable = true;
            plugins = [
                "common-aliases"
                "compleat"
                "git"
                "git-extras"
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
