{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
    name = "powerlevel9k";
    src = fetchFromGitHub {
        owner = "bhilburn";
        repo = "powerlevel9k";
        rev = "master";
        sha256 = "1pwq32ig5cdn41c1swdfbp2lv2iyl15gz3c6al8p9jihs53d503c";
    };

    installPhase = ''
        mkdir -p $out/powerlevel9k
        mv * $out/powerlevel9k
    '';
}
