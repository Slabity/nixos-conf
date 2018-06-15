{
  # This folder is symlinked to `$HOME/.config/nixpkgs` and needs to have these
  # files separate from this `default.nix` file to work appropriately.
  config = import ./config.nix;
  overlays = import ./overlays.nix;
}
