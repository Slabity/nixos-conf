self: super:
{
  powerlevel9k = super.callPackage ./powerlevel9k {};

  hpr = {
    riskconsole = super.callPackage ./hpr/riskconsole { };
    monitoringconsole = super.callPackage ./hpr/riskconsole { };
  };

  nheko = super.libsForQt5.callPackage ./nheko { };

  steam = super.steam.override (
    {
    extraPkgs = p: with p; [ usbutils lsb-release procps dbus_daemon python3 ];
    }
  );
}
