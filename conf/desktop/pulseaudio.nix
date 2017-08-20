{ config, pkgs, ... }:

let pulse = pkgs.pulseaudioLight.override { jackaudioSupport = true; };
in
{
    environment.systemPackages = with pkgs; [ jack2Full ];

    hardware.pulseaudio = {
        enable = true;
        package = pulse;
    };

    systemd.user.services = {
        jackdbus = {
            description = "Runs jack, and points pulseaudio at it";
            serviceConfig = {
                Type = "oneshot";
                ExecStart = pkgs.writeScript "start_jack.sh" ''
                    #! ${pkgs.bash}/bin/bash
                    . ${config.system.build.setEnvironment}

                    ${pkgs.jack2Full}/bin/jack_control start
                    sleep 3 # give some time for sources/sinks to be created

                    ${pulse}/bin/pacmd set-default-sink jack_out
                    ${pulse}/bin/pacmd set-default-source jack_in
                '';
                ExecStop = pkgs.writeScript "stop_jack.sh" ''
                    #! ${pkgs.bash}/bin/bash
                    . ${config.system.build.setEnvironment}

                    ${pkgs.jack2Full}/bin/jack_control stop
                '';
                RemainAfterExit = true;
            };
            wantedBy = [ "default.target" ];
        };
    };
}
