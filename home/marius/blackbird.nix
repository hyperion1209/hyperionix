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
    common/optional/desktops/gnome-extensions.nix
    common/optional/megasync.nix
  ];

  home = {
    username = configVars.username;
    homeDirectory = "/home/${configVars.username}";
  };

  programs.ssh = {
    matchBlocks = {
      "my_vms" = {
        host = "192.168.122.*";
        forwardAgent = true;
      };
      "my_hosts" = {
        host = "192.168.1.*";
        forwardAgent = true;
      };
    };
  };
}
