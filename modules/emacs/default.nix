{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.foxos;
  emacsCfg = cfg.emacs;
in
{
  options.foxos.emacs.enable = mkEnableOption "Use emacs editor.";

  config = mkIf emacsCfg.enable {
    services.emacs.enable = true;

    environment.variables = {
      EDITOR = mkOverride 900 "${pkgs.emacs}/bin/emacs -nw";
    };
  };
}
