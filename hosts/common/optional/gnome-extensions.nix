# Gnome extensions
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.workspace-matrix
    gnomeExtensions.move-clock
    gnomeExtensions.tailscale-status
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-panel

  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
}

