rec {
  hostName = "raichu";
  efiPath = "/boot";
  timeZone = "America/New_York";

  user = "slabity";

  desktop = {
    enable = true;
    laptop = true;
    compton = true;
    monitors = null;
  };

  printing = true;
}
