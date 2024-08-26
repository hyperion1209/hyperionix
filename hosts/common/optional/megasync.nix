# MEGASync

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    megasync
  ];
}
