{ ... }:
{
  imports = [
    ./workstation
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };
}
