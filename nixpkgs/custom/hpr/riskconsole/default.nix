{ stdenv, lib, fetchurl }:

let
  guiUrl = "http://hpr-share/Builds/gui";
in
stdenv.mkDerivation rec {
  name = "riskconsole-${version}";
  version = "RC-3.4.24_3_g590304d5-16Mar2018";

  src = fetchurl {
    url = "http://hpr-share/Builds/gui/riskconsole/${version}/hprRmGUI.jar";
  };
}
