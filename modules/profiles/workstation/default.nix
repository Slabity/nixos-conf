{ config, lib, foxlib, pkgs, ... }:
with lib;
let
  cfg = config.foxos;
  wsCfg = cfg.profiles.workstation;
in
{
  options.foxos.profiles.workstation.enable = mkEnableOption "Workstation";

  config = mkIf wsCfg.enable {
    foxos.zsh.enable = true;
    foxos.i3.enable = true;
    foxos.emacs.enable = true;

    virtualisation.libvirtd.enable = true;

    services.dbus.socketActivated = true;
    services.avahi.enable = true;
    services.mpd.enable = true;
    hardware.pulseaudio = mkIf cfg.hardware.audio.enable {
        enable = true;
        support32Bit = cfg.hardware.cpu.support32Bit;
    };

    environment.systemPackages = with pkgs; [
      rofi
      termite
      numix-gtk-theme
      numix-icon-theme-square
    ];

    fonts.enableDefaultFonts = true;
    fonts.fonts = with pkgs; [
      corefonts source-code-pro source-sans-pro source-serif-pro
      font-awesome-ttf powerline-fonts google-fonts inconsolata noto-fonts
      noto-fonts-cjk unifont ubuntu_font_family nerdfonts
    ];
    fonts.fontconfig = {
      defaultFonts.monospace = [ "Terminess Powerline" ];
      ultimate.enable = false;
    };

    services.printing.enable = true;
    services.printing.drivers = with pkgs; [
      gutenprint
      gutenprintBin
      cupsBjnp
      mfcj470dw-cupswrapper
      mfcj6510dw-cupswrapper
      mfcl2700dncupswrapper
    ];

    networking.networkmanager.enable = true;
    networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];

    boot.loader.grub.enable = true;
    boot.loader.grub.useOSProber = true;
    boot.loader.timeout = 3;

    assertions = [
      (foxlib.reqVar "foxos.mainUser.enable" cfg.mainUser.enable)
    ];
  };
}
