rec {
  hostName = "raichu";
  efiPath = "/boot";
  timeZone = "America/New_York";

  desktop = {
    enable = true;
    laptop = true;
    compton = true;
  };

  printing = true;
}
