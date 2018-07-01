{ config, lib, foxlib, pkgs, ... }:
with lib;
let
  cfg = config.foxos;
  userCfg = cfg.mainUser;
in
{
  options.foxos.mainUser = {
    enable = mkEnableOption "Main (non-root) user";
    name = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Main user name";
    };
  };

  config = mkIf userCfg.enable {
    users = {
      defaultUserShell = if cfg.zsh.enable then pkgs.zsh else pkgs.bash;
      mutableUsers = false;

      extraUsers.${userCfg.name} = {
        uid = 1000;
        isNormalUser = true;

        extraGroups = [
          "wheel"
          "networkmanager"
          "docker"
          "libvirtd"
        ];

        passwordFile = "${../passwd}";
      };
    };

    assertions = [
      (foxlib.reqVar "foxos.mainUser.name" userCfg.name)
    ];
  };
}
