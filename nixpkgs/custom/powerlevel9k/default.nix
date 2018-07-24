{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "powerlevel9k";
  src = fetchFromGitHub {
    owner = "bhilburn";
    repo = "powerlevel9k";
    rev = "master";
    sha256 = "1iv0sdw6x0ji87gxi92a3x2y9lsgqnn1gys7nmqhs35mg1sw66w4";
  };

  installPhase = ''
    mkdir -p $out/powerlevel9k
    mv * $out/powerlevel9k
  '';
}
