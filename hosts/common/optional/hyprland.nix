{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hyprland
    xdg-desktop-portal-hyprland
    seatd
    xwayland
    wl-clipboard
    cliphist
  ];
}
