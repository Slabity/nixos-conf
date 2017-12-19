{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "powerlevel9k";
  src = fetchFromGitHub {
    owner = "bhilburn";
    repo = "powerlevel9k";
    rev = "master";
    sha256 = "0mijf2igsvymk0n3s89wsyf889ahfz45sccsgharm9h2pp4lnp6y";
  };

  installPhase = ''
    mkdir -p $out/powerlevel9k
    mv * $out/powerlevel9k
  '';
}
