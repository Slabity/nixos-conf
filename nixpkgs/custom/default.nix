self: super:
{
  powerlevel9k = super.callPackage ./powerlevel9k {};

  hpr = {
    riskconsole = super.callPackage ./hpr/riskconsole { };
    monitoringconsole = super.callPackage ./hpr/riskconsole { };
  };

  nheko = super.libsForQt5.callPackage ./nheko { };

  #rustCustom = super.latest.rustChannels.nightly.rust.overrideAttrs (old: rec {
  #  name = "rustCustom";
  #});

  rustCustom = super.rust.overrideAttrs (old: rec {
    name = "rustCustom";
  });
}
