{ config, lib, foxlib, ... }:
with lib;
let
  cfg = config.foxos;
  sysCfg = cfg.system;
in
{
  options.foxos.system = {
    name = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Name of the system.";
    };

    version = mkOption {
      type = types.str;
      default = "18.09";
      description = "Upstream NixOS version to base on";
    };
  };

  config = {
    system.nixos.label = if sysCfg.name == null then "" else sysCfg.name;
    system.stateVersion = sysCfg.version;

    assertions = [
      (foxlib.reqVar "foxos.system.name" sysCfg.name)
    ];
  };
}
