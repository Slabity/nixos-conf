{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
    name = "powerlevel9k";
    src = fetchFromGitHub {
        owner = "bhilburn";
        repo = "powerlevel9k";
        rev = "master";
        sha256 = "10962xypbcnr8jy8g1p0yh065zrqsck9wj7jzsd54dmll5yh08p3";
    };

    installPhase = ''
        mkdir -p $out/powerlevel9k
        mv * $out/powerlevel9k
    '';
}
