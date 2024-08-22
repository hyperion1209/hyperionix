{
  description = "System Config Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux";
        locale = "en_US.UTF-8";
        timezone = "Europe/Warsaw";
      };

      userSettings = {
        username = "marius";
	name = "Marius Stan";
      };

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = systemSettings.system;
        modules = [ ./configuration.nix ];
	specialArgs = {
	  inherit systemSettings;
	  inherit userSettings;
	};
      };
    };
    homeConfigurations = {
      marius = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
	extraSpecialArgs = {
	  inherit userSettings;
	};
      };
    };
  };
}
