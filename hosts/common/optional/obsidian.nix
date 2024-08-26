# Obsidian

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    obsidian
  ];
}
