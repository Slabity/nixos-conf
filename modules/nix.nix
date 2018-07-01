{ config, lib, ... }:
with lib;
let
  cfg = config.foxos;

  cpuCfg = cfg.hardware.cpu;
  totalThreads = cpuCfg.sockets * cpuCfg.cores * cpuCfg.threads;

  isWorkstation = cfg.profiles.workstation.enable;

  responsive = 5;
in
{
  config = {
    nix.daemonNiceLevel = mkIf isWorkstation responsive;
    nix.daemonIONiceLevel = mkIf isWorkstation responsive;

    nix.maxJobs = totalThreads;
    nix.buildCores = totalThreads;

    nix.readOnlyStore = true;
    nix.autoOptimiseStore = true;

    nix.allowedUsers = [ "@wheel" ];
  };
}
