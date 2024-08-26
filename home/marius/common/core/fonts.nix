{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # noto-fonts
    (nerdfonts.override { fonts = [ "Hack" ]; })
    # meslo-lgs-nf
  ];
}
