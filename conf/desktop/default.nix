{ config, pkgs, expr, ... }:

{
    imports = [
        ./sway.nix
        ./pulseaudio.nix
    ];

    hardware.opengl.driSupport = true;
    hardware.opengl.extraPackages = with pkgs; [
        vaapiIntel      # Video Accel API by Intel
        libvdpau-va-gl  # VDPAU driver using VAAPI
        beignet         # OpenCL for Intel
    ];

    services.xserver = {
        enable = true;

        # Input
        layout = "us";
        libinput.enable = true;
        libinput.tapping = false;
        libinput.tappingDragLock = false;

        # Display Manager
        displayManager.logToJournal = true;
        displayManager.lightdm.enable = true;
        displayManager.lightdm.autoLogin = {
            enable = true;
            user = "slabity";
        };
        displayManager.lightdm.greeter.enable = false;

        # Desktop Environment
        desktopManager.xterm.enable = false;
        windowManager.i3.enable = true;
        windowManager.i3.package = pkgs.i3-gaps;
        windowManager.i3.configFile = "${./i3conf}";
        windowManager.sway.enable = true;
        windowManager.sway.configFile = "${./i3conf}";
        windowManager.default = "sway";

        # Drivers
        videoDrivers = [ "ati" "modesetting" ];
        useGlamor = true;

        desktopManager.session = [
            {
                name = "custom";
                start = ''
                    # Load custom Xresources
                    ${pkgs.xlibs.xrdb}/bin/xrdb -load ${./Xresources}

                    # Start notifications
                    ${pkgs.dunst}/bin/dunst
                '';
            }
        ];

        desktopManager.default = "custom";
    };

    #services.compton = {
    #    enable = true;
    #    fade = true;
    #    inactiveOpacity = "0.8";
    #    shadow = true;
    #    fadeDelta = 3;
    #    backend = "glx";
    #    vSync = "opengl-mswc";
    #};

    services.mpd.enable = true;
    services.tlp.enable = true;

    environment.systemPackages = with pkgs; [
        firefox
        krita
        gimp
        steam
        patchage
        ardour
        polybar
        rofi
        dunst
        termite
        arc-theme
        paper-icon-theme
        xorg.xbacklight
    ];

    fonts.enableDefaultFonts = true;
    fonts.fonts = with pkgs; [
        corefonts source-code-pro source-sans-pro source-serif-pro
        font-awesome-ttf powerline-fonts google-fonts inconsolata noto-fonts
        noto-fonts-cjk unifont ubuntu_font_family nerdfonts
    ];

    fonts.fontconfig = {
        defaultFonts.monospace = [ "TerminessTTF Nerd Font" ];
        ultimate.enable = false;
    };

    nixpkgs.config.firefox.enableAdobeFlash = true;
}
