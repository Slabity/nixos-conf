rec {
  hostName = "mew";
  efiPath = "/boot";
  timeZone = "America/New_York";

  desktop = {
    enable = true;
    laptop = false;
    compton = true;
  };

  printing = false;
}
