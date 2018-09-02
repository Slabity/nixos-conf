{ config, ... }:
{
  imports = [
    ../modules
    ../hardware-configuration.nix
  ];

  foxos.system.name = "mew";

  foxos.hardware.efi = true;

  foxos.hardware.cpu = {
    type = "intel";
    sockets = 1;
    cores = 4;
    threads = 2;
    support32Bit = true;
  };

  foxos.hardware.gpu.enable = true;
  foxos.hardware.gpu.type.intel = true;
  foxos.hardware.gpu.type.amd = true;

  foxos.hardware.ethernet.enable = true;
  foxos.hardware.wifi.enable = true;
  foxos.hardware.bluetooth.enable = true;
  foxos.hardware.audio.enable = true;
  foxos.hardware.input.enable = true;
  foxos.hardware.battery.enable = false;

  foxos.profiles.workstation.enable = true;

  foxos.mainUser.enable = true;
  foxos.mainUser.name = "slabity";

  boot.loader.grub.enableCryptodisk = true;
  time.timeZone = "America/New_York";
  virtualisation.libvirtd.enable = true;

  services.xserver.xrandrHeads = [
    {
      output = "HDMI-A-0";
      primary = true;
    }
    {
      output = "DVI-D-0";
      primary = false;
      monitorConfig = ''
        Option "PreferredMode" "2560x1440"
      '';
    }
  ];

}
