{ config, pkgs, expr, sys, ... }:

let
  monitors = if (sys.desktop.monitors != null) then sys.desktop.monitors else [];
in
with builtins; with pkgs.lib; {
  imports = [
    ./pulseaudio.nix
  ];

  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel      # Video Accel API by Intel
    libvdpau-va-gl  # VDPAU driver using VAAPI
    beignet         # OpenCL for Intel
  ];

  services.xserver = {
    enable = true;

    # Input
    layout = "us";
    libinput = {
        enable = true;
        accelProfile = "flat";
        accelSpeed = "-0.60";
        tapping = false;
        tappingDragLock = false;
    };

    # Display Manager
    displayManager.job.logToJournal = true;
    displayManager.lightdm.enable = true;
    displayManager.lightdm.autoLogin = {
      enable = true;
      user = if (sys.user != null) then sys.user else "slabity";
    };
    displayManager.lightdm.greeter.enable = false;

    # Desktop Environment
    desktopManager.xterm.enable = false;
    windowManager.i3.enable = true;
    windowManager.i3.package = pkgs.i3-gaps;
    windowManager.i3.configFile = "${./i3conf}";
    windowManager.default = "i3";

    # Drivers
    videoDrivers = [ "amdgpu" "modesetting" ];
    useGlamor = true;

    desktopManager.session = [
      {
        name = "custom";
        start = ''
          # Set background
          ${pkgs.feh}/bin/feh --bg-scale ${./background.jpg}

          # Load custom Xresources
          ${pkgs.xlibs.xrdb}/bin/xrdb -load ${./Xresources}

          # Start notifications
          ${pkgs.dunst}/bin/dunst &
        '';
      }
    ];

    xrandrHeads = monitors;
    desktopManager.default = "custom";
  };

  services.compton = {
    enable = true;
    backend = "glx";
    vSync = "opengl-mswc";
    activeOpacity = "0.9";
    inactiveOpacity = "0.8";
    menuOpacity = "0.9";
    shadow = true;
    fade = true;
    fadeDelta = 3;
    opacityRules = [ "100:_NET_WM_NAME@:s *?= 'rofi'"];
  };

  services.redshift = {
    enable = true;
    latitude = "43";
    longitude = "-71";
    brightness.day = "1";
    brightness.night = "0.5";
    temperature.day = 6500;
    temperature.night = 3500;
  };

  services.mpd.enable = true;
  services.tlp.enable = true;

  environment.systemPackages = with pkgs; [
    polybar
    rofi
    termite
    numix-icon-theme-square
    numix-gtk-theme
    conky
  ];

  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    corefonts source-code-pro source-sans-pro source-serif-pro
    font-awesome-ttf powerline-fonts google-fonts inconsolata noto-fonts
    noto-fonts-cjk unifont ubuntu_font_family nerdfonts
  ];

  fonts.fontconfig = {
    defaultFonts.monospace = [ "Terminess Powerline" ];
    ultimate.enable = false;
  };

  services.avahi.enable = true;
}
