{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    alacritty
  ];
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    colors = {
      bright = {
        black = "0x3c3836";
        blue = "0x7daea3";
        cyan = "0x89b482";
        green = "0xa9b665";
        magenta = "0xd3869b";
        red = "0xea6962";
        white = "0xd4be98";
        yellow = "0xd8a657";
      };
      normal = {
        black = "0x3c3836";
        blue = "0x7daea3";
        cyan = "0x89b482";
        green = "0xa9b665";
        magenta = "0xd3869b";
        red = "0xea6962";
        white = "0xd4be98";
        yellow = "0xd8a657";
      };
      primary = {
        background = "0x282828"
        foreground = "0xd4be98"
      };
    };
    cursor.style.blinking = "Never";
    font = {
      size = 13.0;
      bold = {
        family = "Hack Nerd Font Mono";
        style = "Bold";
      };
      bold_italic = {
        family = "Hack Nerd Font Mono";
        style = "Bold Italic";
      };
      italic = {
        family = "Hack Nerd Font Mono";
        style = "Italic";
      };
      normal = {
        family = "Hack Nerd Font Mono";
        style = "Regular";
      };
      offset = {
        x = 0;
        y = 0;
      };
      glyph_offset = {
        x = 0;
        y = 0;
      };
    };
    keyboard.bindings = [
      {
        action = "Paste";
        key = "V";
        mods = "Control|Shift";
      }
      {
        action = "Copy";
        key = "C";
        mods = "Control|Shift";
      }
      {
        action = "IncreaseFontSize";
        key = "Equals";
        mods = "Control";
      }
      {
        action = "DecreaseFontSize";
        key = "Minus";
        mods = "Control";
      }
    ];
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
