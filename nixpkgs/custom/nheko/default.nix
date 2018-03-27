{ stdenv, lib, fetchFromGitHub, qtbase, qttranslations, qtmultimedia, lmdb, cmake, git, tree }:

let
  matrix-structs = fetchFromGitHub {
    owner  = "mujx";
    repo   = "matrix-structs";
    rev    = "850100c0ac2b5a04720b2a1f09270749bf99f7dd";
    sha256 = "1r9n1744zbyqhqs0i9jzsi9pl922vl9a33r5ighpkmhz1dm0ryph";
    fetchSubmodules = true;
  };

  lmdbxx = fetchFromGitHub {
    owner = "bendiken";
    repo = "lmdbxx";
    rev = "0b43ca87d8cfabba392dfe884eb1edb83874de02";
    sha256 = "1whsc5cybf9rmgyaj6qjji03fv5jbgcgygp956s3835b9f9cjg1n";
    fetchSubmodules = true;
  };
in
stdenv.mkDerivation rec {
  name = "nheko-${version}";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner  = "mujx";
    repo   = "nheko";
    rev    = "v${version}";
    sha256 = "18xbmg9xmx2jsz7q5gqlh6qwd9fnw4zmsyimmf8rf40z6vm5fqb0";
    fetchSubmodules = true;
  };

  buildInputs = [ qtbase qttranslations qtmultimedia lmdb matrix-structs ];

  nativeBuildInputs = [ cmake git ];

  enableParallelBuilding = true;

  patches = [ ./my.patch ];

  preConfigure = ''
    mkdir -p .third-party
    cp -r ${matrix-structs} .third-party/matrix_structs
    cp -r ${lmdbxx} .third-party/lmdbxx
    chmod -R +w .third-party/matrix_structs
    chmod -R +w .third-party/lmdbxx
    ${tree}/bin/tree -a .
  '';

  installPhase = "install -Dm755 nheko $out/bin/nheko";

  meta = with lib; {
    description = "Desktop client for the Matrix protocol";
    homepage    = https://github.com/mujx/nheko;
    license     = licenses.gpl3;
    #maintainers = with maintainers; [ slabity ];
    inherit (qtbase.meta) platforms;
    inherit version;
  };
}
