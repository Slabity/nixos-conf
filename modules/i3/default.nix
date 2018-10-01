{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.foxos;
  i3Cfg = cfg.i3;
in
{
  options.foxos.i3.enable = mkEnableOption "i3 Window Manager";

  config = mkIf i3Cfg.enable {
    services.xserver = {
      enable = true;

      layout = "us";
      libinput = {
        enable = true;
        accelProfile = "flat";
        tapping = false;
        tappingDragLock = false;
      };

      displayManager.job.logToJournal = true;
      displayManager.lightdm.enable = true;
      displayManager.lightdm.autoLogin = {
        enable = true;
        user = cfg.mainUser.name;
      };
      displayManager.lightdm.greeter.enable = false;

      desktopManager.xterm.enable = false;
      windowManager.i3.enable = true;
      windowManager.i3.package = pkgs.i3-gaps;
      windowManager.i3.configFile = "${./i3conf}";
      windowManager.default = "i3";

      videoDrivers = [ "amdgpu-pro" "modesetting" ];
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

      desktopManager.default = "custom";
    };

    services.compton = {
      enable = true;
      backend = "xr_glx_hybrid";
      vSync = "drm";
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
  };
}
