{ config, lib, foxlib, pkgs, ... }:
with lib;
let
  cfg = config.foxos;
  hwCfg = cfg.hardware;
in
{
  options.foxos.hardware = {
    virtual = mkEnableOption "Virtual hardware support";
    efi = mkEnableOption "Uses EFI for boot";

    cpu = {
      type = mkOption {
        type = types.nullOr (types.enum [
          "amd" "intel"
        ]);
        default = null;
        description = "Type of processor.";
      };

      sockets = mkOption {
        type = types.ints.positive;
        default = 1;
        description = "Number of CPU sockets.";
      };

      cores = mkOption {
        type = types.ints.positive;
        default = 1;
        description = "Number of cores per CPU.";
      };

      threads = mkOption {
        type = types.ints.positive;
        default = 1;
        description = "Number of threads per core.";
      };

      support32Bit = mkEnableOption "Processor can run 32-bit apps";
    };

    gpu.enable = mkEnableOption "Has a GPU";
    gpu.type.intel = mkEnableOption "Has Intel integrated GPU";
    gpu.type.amd = mkEnableOption "Has AMD dedicated GPU";

    ethernet.enable = mkEnableOption "Ethernet ports";
    wifi.enable = mkEnableOption "WiFi";
    bluetooth.enable = mkEnableOption "Bluetooth";
    audio.enable = mkEnableOption "Audio";
    input.enable = mkEnableOption "Input devices (keyboard, mouse, etc.)";
    battery.enable = mkEnableOption "Battery";
  };

  config = {
    hardware.cpu.amd.updateMicrocode = hwCfg.cpu.type == "amd";
    hardware.cpu.intel.updateMicrocode = hwCfg.cpu.type == "intel";

    services.tlp.enable = hwCfg.battery.enable;

    hardware.opengl = mkIf hwCfg.gpu.enable {
      enable = true;
      driSupport = true;
      driSupport32Bit = hwCfg.cpu.support32Bit;

      extraPackages = mkIf hwCfg.gpu.type.intel [
        pkgs.libGL
        pkgs.vaapiIntel      # Video Accel API by Intel
        pkgs.libvdpau-va-gl  # VDPAU driver using VAAPI
        pkgs.vaapiVdpau
        pkgs.intel-ocl
      ];

      extraPackages32 = mkIf hwCfg.cpu.support32Bit [
        pkgs.pkgsi686Linux.libGL
        pkgs.pkgsi686Linux.vaapiIntel      # Video Accel API by Intel
        pkgs.pkgsi686Linux.libvdpau-va-gl  # VDPAU driver using VAAPI
        pkgs.pkgsi686Linux.vaapiVdpau
      ];
    };

    boot.loader.grub = mkIf hwCfg.efi {
      efiSupport = true;
      device = "nodev";
    };
  };
}
