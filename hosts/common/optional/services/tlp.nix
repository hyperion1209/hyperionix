{
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0=75;
      STOP_CHARGE_THRESH_BAT0=80;

      START_CHARGE_THRESH_BAT1=75;
      STOP_CHARGE_THRESH_BAT1=80;
    };
  };
}
