{ configVars, ... }:
{
  imports = [
    #################### Required Configs ####################
    common/core # required

    #################### Host-specific Optional Configs ####################
    common/optional/sops.nix
    common/optional/browsers/firefox.nix
    # common/optional/helper-scripts

    common/optional/desktops/gtk.nix
  ];

  # services.yubikey-touch-detector.enable = true;

  home = {
    username = configVars.username;
    homeDirectory = "/home/${configVars.username}";
  };
}
