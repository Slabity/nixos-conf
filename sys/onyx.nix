rec {
  hostName = "onyx";
  efiPath = "/boot";
  timeZone = "America/New_York";

  desktop = {
    enable = true;
    laptop = false;
    compton = true;
  };

  printing = true;
  tmux = false;
}
