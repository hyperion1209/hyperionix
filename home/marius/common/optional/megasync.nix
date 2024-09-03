{ pkgs, ... }:
{
  services.megasync = {
    enable = true;
    package = pkgs.megasync;
  };
}
