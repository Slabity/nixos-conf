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
        interactiveShellInit = ''
            DEFAULT_USER=slabity

            POWERLEVEL9K_MODE='awesome-fontconfig'

            POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode vcs dir dir_writable)
            POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs)
            POWERLEVEL9K_SHORTEN_STRATEGY=truncate_left

            POWERLEVEL9K_HOME_ICON='\uf015'
            POWERLEVEL9K_HOME_SUB_ICON='\uf015'
            POWERLEVEL9K_FOLDER_ICON='\uf413'
            POWERLEVEL9K_DIR_WRITABLE_ICON='\uf413'
            POWERLEVEL9K_LOCK_ICON='\uf023'

            POWERLEVEL9K_VI_INSERT_MODE_STRING='\uf040'
            POWERLEVEL9K_VI_COMMAND_MODE_STRING='\uf120'

            POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true
            POWERLEVEL9K_DIR_PATH_SEPARATOR=" $(printf '\ue0b1') "

            POWERLEVEL9K_DIR_HOME_BACKGROUND="001"
            POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=$POWERLEVEL9K_DIR_HOME_BACKGROUND
            POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=$POWERLEVEL9K_DIR_HOME_BACKGROUND
            POWERLEVEL9K_DIR_HOME_FOREGROUND="014"
            POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=$POWERLEVEL9K_DIR_HOME_FOREGROUND
            POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=$POWERLEVEL9K_DIR_HOME_FOREGROUND

            POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND="015"
            POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND=$POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND
            POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND="014"
            POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND=$POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND

            POWERLEVEL9K_VCS_CLEAN_BACKGROUND="006"
            POWERLEVEL9K_VCS_CLEAN_FOREGROUND="001"
            POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="010"
            POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="000"
            POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="010"
            POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="000"

            compinit
          '';
    };

    nix = {
        autoOptimiseStore = true;
        daemonNiceLevel = 1;
        daemonIONiceLevel = 1;
    };
}
