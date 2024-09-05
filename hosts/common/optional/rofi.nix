{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ 
    rofi-wayland
    wofi
  ];
}
