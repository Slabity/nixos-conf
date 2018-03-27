self: super:
{
  hpr = {
    riskconsole = super.callPackage ./hpr/riskconsole { };
    monitoringconsole = super.callPackage ./hpr/riskconsole { };
  };

  nheko = super.libsForQt5.callPackage ./nheko { };
}
