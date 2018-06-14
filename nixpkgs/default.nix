{ ... }:
let
  mozillaOverlayUrl = https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
in
{
  config = {
    allowBroken = false;
    allowUnfree = true;
  };

  overlays = [
    (import (builtins.fetchTarball mozillaOverlayUrl))
    (import ./custom)
  ];
}
