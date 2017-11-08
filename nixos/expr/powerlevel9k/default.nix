{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
    name = "powerlevel9k";
    src = fetchFromGitHub {
        owner = "bhilburn";
        repo = "powerlevel9k";
        rev = "master";
        sha256 = "1g09fwbrj7h0j7mqmbhq7rnqc79ckr9q6k31zmdn3xrnz2myir25";
    };

    installPhase = ''
        mkdir -p $out/powerlevel9k
        mv * $out/powerlevel9k
    '';
}
