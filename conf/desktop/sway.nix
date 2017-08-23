{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.services.xserver.windowManager.sway;
in
{
    options.services.xserver.windowManager.sway = {
        enable = mkEnableOption "sway compositor";

        xwayland = mkEnableOption "xwayland support";

        configFile = mkOption {
            default = null;
            type = with types; nullOr path;
            description = ''
                Path to config file.
            '';
        };

        package = mkOption {
            type = types.package;
            default = pkgs.sway;
            defaultText = "pkgs.sway";
            example = "pkgs.sway";
            description = ''
                sway package to use
            '';
        };
    };

    config = mkIf cfg.enable {
        services.xserver.windowManager.session = [{
            name = "sway";
            start = ''
                ${cfg.package}/bin/sway ${optionalString (cfg.configFile != null)
                    "-c \"${cfg.configFile}\""
                } &
                waitPID=$!
            '';
        }];

        environment.systemPackages = [
            cfg.package
            pkgs.xwayland
        ];
    };
}
