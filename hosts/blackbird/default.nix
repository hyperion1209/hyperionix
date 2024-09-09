{ inputs, configLib, ... }:
{
  imports =
    [
      #################### Every Host Needs This ####################
      ./hardware-configuration.nix

      #################### Hardware Modules ####################
      inputs.hardware.nixosModules.common-cpu-intel

      #################### Disk Layout ####################
    #   inputs.disko.nixosModules.disko
    #   (configLib.relativeToRoot "hosts/common/disks/standard-disk-config.nix")
    #   {
    #     _module.args = {
    #       disk = "/dev/vda";
    #       withSwap = false;
    #     };
    #   }
    ]
    ++ (map configLib.relativeToRoot [
      #################### Required Configs ####################
      "hosts/common/core"

      #################### Host-specific Optional Configs ####################
      "hosts/common/optional/obsidian.nix"
      "hosts/common/optional/vlc.nix"
      "hosts/common/optional/calibre.nix"
      "hosts/common/optional/whatsapp.nix"
      "hosts/common/optional/gnome-extensions.nix"
      "hosts/common/optional/xfce.nix" # window manager until I get hyprland configured
      "hosts/common/optional/virtmanager.nix"

      "hosts/common/optional/services/printing.nix"
      "hosts/common/optional/services/pipewire.nix"
      "hosts/common/optional/services/xserver.nix"
      "hosts/common/optional/services/tlp.nix"
      #    "hosts/common/optional/initrd-ssh.nix"
      # "hosts/common/optional/yubikey"
      # "hosts/common/optional/services/clamav.nix" # depends on optional/msmtp.nix
      # "hosts/common/optional/msmtp.nix" # required for emailing clamav alerts
      "hosts/common/optional/services/openssh.nix"

      # Desktop
      # "hosts/common/optional/services/greetd.nix" # display manager
      # "hosts/common/optional/hyprland.nix" # window manager

      #################### Users to Create ####################
      "hosts/common/users/marius"
    ]);

  services.gnome.gnome-keyring.enable = true;
  # TODO enable and move to greetd area? may need authentication dir or something?
  # services.pam.services.greetd.enableGnomeKeyring = true;

  # Enable some basic X server options
  services.xserver.enable = true;
    services.xserver.displayManager = {
  };

  networking = {
    hostName = "blackbird";
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.initrd = {
    systemd.enable = true;
  };

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
