{ pkgs ? import <nixpkgs> {} }: with pkgs;

rec {
  powerlevel9k = callPackage ./powerlevel9k {};

  acsOverride = {
    name = "acs-override";
    patch = ./patches/override_for_missing_acs_capabilities.patch;
  };

  emacsHead = pkgs.emacs.overrideDerivation (oldAttrs: {
    version = "26.0a";
    src = pkgs.fetchgit {
      url = "https://git.savannah.gnu.org/git/emacs.git/";
      sha256 = "0172j9firvnvrpgdc95zs7fkvgh801xh74n18a1yispicxagkspg";
      fetchSubmodules = true;
    };
    patches = [];
  });

  emacs = emacsHead.override { srcRepo = true; };
}
