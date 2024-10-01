{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    adguardhome
  ];

  services.adguardhome = {
    enable = true;
  };
}
