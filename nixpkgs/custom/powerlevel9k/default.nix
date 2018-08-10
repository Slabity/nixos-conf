{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "powerlevel9k";
  src = fetchFromGitHub {
    owner = "dritter";
    repo = "powerlevel9k";
    rev = "prepare_066";
    sha256 = "11prlvygmz3p4g6wsyxy1zziyrmm6wham7qznfncy4yzg6jwfcp0";
  };

  installPhase = ''
    mkdir -p $out/powerlevel9k
    mv * $out/powerlevel9k
  '';
}
