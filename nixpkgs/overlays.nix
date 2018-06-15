let
  mozillaOverlayUrl = https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
in
[
  (import (builtins.fetchTarball mozillaOverlayUrl))
  (import ./custom)
]
