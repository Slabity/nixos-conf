{
  network.description = "My network";

  resources.sshKeyPairs.ssh-key = {};

  valgrindweb = { config, pkgs, ... }: {
    services.httpd.enable = true;
    services.httpd.adminAddr = "alice@example.org";
    services.httpd.documentRoot = "${pkgs.valgrind.doc}/share/doc/valgrind/html";
    networking.firewall.allowedTCPPorts = [ 80 ];

    deployment.targetEnv = "digitalOcean";
    deployment.digitalOcean.enableIpv6 = true;
    deployment.digitalOcean.region = "ams2";
    deployment.digitalOcean.size = "512mb";
  };
}
