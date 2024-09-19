{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.transmission
  ];
}
