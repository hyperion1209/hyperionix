{ pkgs, ... }:
{
  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        appindicator.extensionUuid
        workspace-matrix.extensionUuid
        move-clock.extensionUuid
        tailscale-status.extensionUuid
        vitals.extensionUuid
        dash-to-panel.extensionUuid
        places-status-indicator.extensionUuid

      ];
    };
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
