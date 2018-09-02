let
  mozillaOverlayUrl = https://github.com/Slabity/nixpkgs-mozilla/archive/master.tar.gz;
in
[
  (import (builtins.fetchTarball mozillaOverlayUrl))
  (import ./custom)
]
