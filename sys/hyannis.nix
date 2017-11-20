rec {
  hostName = "tslabinski-nixos";
  efiPath = "/boot";
  timeZone = "America/New_York";

  user = "tslabinski";

  desktop = {
    enable = true;
    laptop = false;
    compton = true;
    monitors = [
      {
        output = "HDMI-1";
        primary = true;
      }
      {
        output = "HDMI-3";
        primary = false;
#        monitorConfig = ''
#          Mode "3440x1440"
#        '';
      }
    ];
  };

  printing = true;
}
