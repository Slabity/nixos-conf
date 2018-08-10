let
  region = "us-east-1";
  accessKeyId = "personal";
  keyPair = { inherit region accessKeyId; };

  dummyConfig = builtins.toFile "configuration.nix" ''
    builtins.trace "This machine is managed by NixOps, using dummy configuration file for evaluation" {
    fileSystems."/".device = "/dev/sda1";
    boot.loader.grub.device = "nodev";

    assertions = [{
      assertion = false;
      message = "Cannot build machine managed by NixOps";
    }];
  }'';
in
{
  network.description = "My network";

  defaults = {
    nix.nixPath = [
      "nixos-config=${dummyConfig}"
    ];
    imports = [
      ../modules
    ];
  };

  nextcloud = { resources, config, pkgs, ... }: {
    foxos.system.name = "NextCloud";
    imports = [
      ./nextcloud.nix
    ];

    services.lighttpd.enable = true;
    services.lighttpd.nextcloud.enable = true;

    networking.firewall.allowedTCPPorts = [ 80 ];

    deployment.targetEnv = "ec2";
    deployment.ec2.accessKeyId = accessKeyId;
    deployment.ec2.region = region;
    deployment.ec2.instanceType = "t2.micro";
    deployment.ec2.keyPair = resources.ec2KeyPairs.keyPair;
  };

  resources.ec2KeyPairs.keyPair = keyPair;
}
