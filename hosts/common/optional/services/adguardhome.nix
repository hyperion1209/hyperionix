{ pkgs, ... }:
{
  services.adguardhome = {
    enable = true;
    package = pkgs.adguardhome;
    openFirewall = true;
    mutableSettings = false;
  };
}
