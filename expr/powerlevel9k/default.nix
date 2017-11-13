{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
    name = "powerlevel9k";
    src = fetchFromGitHub {
        owner = "bhilburn";
        repo = "powerlevel9k";
        rev = "master";
        sha256 = "064jd4r6zwgar8jghydmrs32fzifivi6hi5njxy8bswfvw9jz074";
    };

    installPhase = ''
        mkdir -p $out/powerlevel9k
        mv * $out/powerlevel9k
    '';
}
