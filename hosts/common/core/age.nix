# Age
# Modern encryption tool with small explicit keys

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    age
    sops
  ];
}
