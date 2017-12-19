let

mozillaPkgsDir = (import <nixpkgs>{overlays=[];}).fetchFromGitHub {
  owner = "mozilla";
  repo = "nixpkgs-mozilla";
  rev = "HEAD";
  #sha256 = "1shz56l19kgk05p2xvhb7jg1whhfjix6njx1q4rvrc5p1lvyvizd";
  fetchSubmodules = true;
};

in
[
    (import "${mozillaPkgsDir}/rust-overlay.nix")
    (import "${mozillaPkgsDir}/firefox-overlay.nix")
]
