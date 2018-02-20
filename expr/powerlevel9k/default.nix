{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "powerlevel9k";
  src = fetchFromGitHub {
    owner = "bhilburn";
    repo = "powerlevel9k";
    rev = "master";
    sha256 = "1lb6cmslz0492yz4ldkqx9q1w4r4jg26j1w254rjm8wbvqh3h822";
  };

  installPhase = ''
    mkdir -p $out/powerlevel9k
    mv * $out/powerlevel9k
  '';
}
