{
  description = "System Config Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }:
    let
      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux";
        locale = "en_US.UTF-8";
        timezone = "Europe/Warsaw";
	profile = "personal";
      };

      userSettings = {
        username = "marius";
	name = "Marius Stan";
	email = "hyperion1209@gmail.com";
      };

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = systemSettings.system;
        modules = [
	  (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
	];
	specialArgs = {
	  inherit systemSettings;
	  inherit userSettings;
	};
      };
    };
    homeConfigurations = {
      marius = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
	  (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
	  nixvim.homeManagerModules.nixvim
	];
	extraSpecialArgs = {
	  inherit userSettings;
	};
      };
    };
  };
}
