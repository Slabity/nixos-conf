rec {
  hostName = "onyx";
  efiPath = "/boot";
  timeZone = "America/New_York";

  user = "tslabinski";

  desktop = {
    enable = true;
    laptop = false;
    compton = true;
  };

  printing = true;
}
