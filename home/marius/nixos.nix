{ configVars, ... }:
{
  imports = [
    #################### Required Configs ####################
    common/core # required

    #################### Host-specific Optional Configs ####################
    common/optional/alacritty.nix
    common/optional/browsers/firefox.nix
    # common/optional/helper-scripts

    # common/optional/desktops
  ];

  # services.yubikey-touch-detector.enable = true;

  home = {
    username = configVars.username;
    homeDirectory = "/home/${configVars.username}";
  };
}
