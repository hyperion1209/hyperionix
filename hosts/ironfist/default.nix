{ inputs, configLib, ... }:
{
  imports =
    [
      #################### Every Host Needs This ####################
      ./hardware-configuration.nix

      #################### Hardware Modules ####################
      inputs.hardware.nixosModules.common-cpu-intel

      #################### Disk Layout ####################
      inputs.disko.nixosModules.disko
      (configLib.relativeToRoot "hosts/common/disks/standard-disk-config.nix")
      {
        _module.args = {
          disk = "/dev/sda";
          withSwap = false;
        };
      }
    ]
    ++ (map configLib.relativeToRoot [
      #################### Required Configs ####################
      "hosts/common/core"

      #################### Host-specific Optional Configs ####################
      "hosts/common/optional/services/openssh.nix"
      "hosts/common/optional/services/adguardhome.nix"

      #################### Users to Create ####################
      "hosts/common/users/marius"
    ]);

  networking = {
    hostName = "ironfist";
    networkmanager.enable = true;
    enableIPv6 = false;
    useDHCP = false;
    interfaces.eno1 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "192.168.1.123";
        prefixLength = 24;
      }];
    };
    defaultGateway = "192.168.1.1";
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
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
