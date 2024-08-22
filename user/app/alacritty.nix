{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    alacritty
  ];
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window = {
      opacity = lib.mkForce 0.85;
      dynamic_title = true;
      padding = {
        x = 2;
	y = 2;
      };
    };
  };
}
