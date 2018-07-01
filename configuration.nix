{ config, ... }:
{
  imports = [
    ./modules
    ./hardware-configuration.nix
  ];

  foxos.system.name = "raichu";

  foxos.hardware.efi = true;

  foxos.hardware.cpu = {
    type = "intel";
    sockets = 1;
    cores = 4;
    threads = 1;
  };

  foxos.hardware.gpu.enable = true;
  foxos.hardware.gpu.type.intel = true;
  foxos.hardware.gpu.type.amd = false;

  foxos.hardware.ethernet.enable = true;
  foxos.hardware.wifi.enable = true;
  foxos.hardware.bluetooth.enable = true;
  foxos.hardware.audio.enable = true;
  foxos.hardware.input.enable = true;
  foxos.hardware.battery.enable = true;

  foxos.profiles.workstation.enable = true;

  foxos.mainUser.enable = true;
  foxos.mainUser.name = "slabity";

  boot.loader.grub.enableCryptodisk = true;
  time.timeZone = "America/New_York";
}
