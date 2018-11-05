self: super:
{
  powerlevel9k = super.callPackage ./powerlevel9k {};

  steam = super.steam.override (
    {
    extraPkgs = p: with p; [ usbutils lsb-release procps dbus_daemon python3 ];
    }
  );
}
