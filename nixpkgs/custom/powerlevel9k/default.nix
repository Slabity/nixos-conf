{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "powerlevel9k";
  src = fetchFromGitHub {
    owner = "dritter";
    repo = "powerlevel9k";
    rev = "prepare_066";
    sha256 = "0glhzcvbl02ahblphxg6f5lpz1lf0nvy22zakk6jhgwwgh8f3vhl";
  };

  installPhase = ''
    mkdir -p $out/powerlevel9k
    mv * $out/powerlevel9k
  '';
}
