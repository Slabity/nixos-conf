self: super:
{
  powerlevel9k = super.callPackage ./powerlevel9k {};

  hpr = {
    riskconsole = super.callPackage ./hpr/riskconsole { };
    monitoringconsole = super.callPackage ./hpr/riskconsole { };
  };

  nheko = super.libsForQt5.callPackage ./nheko { };
}
