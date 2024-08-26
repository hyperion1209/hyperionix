{ inputs, lib }:
{
  networking = import ./networking.nix { inherit lib; };

  username = "marius";
  #domain = inputs.nix-secrets.domain;
  #userFullName = inputs.nix-secrets.full-name;
  handle = "hyperion1209";
  userEmail = "hyperion1209@gmail.com";
  # gitHubEmail = "7410928+emergentmind@users.noreply.github.com";
  # gitLabEmail = "2889621-emergentmind@users.noreply.gitlab.com";
  #workEmail = inputs.nix-secrets.work-email;
  persistFolder = "/persist";
  isMinimal = false; # Used to indicate nixos-installer build
  defaultLocale = "en_US.UTF-8";
  defaultTimeZone = "Europe/Warsaw";
}
