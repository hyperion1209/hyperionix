{
  config,
  lib,
  pkgs,
  outputs,
  configLib,
  ...
}:
{
  imports = (configLib.scanPaths ./.);
            # ++ (builtins.attrValues outputs.homeManagerModules);

  services.ssh-agent.enable = true;

  home = {
    username = lib.mkDefault "marius";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.05";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      FLAKE = "$HOME/hyperionix";
      SHELL = "zsh";
      TERM = "alacritty";
      TERMINAL = "alacritty";
      EDITOR = "lvim";
      MANPAGER = "batman"; # see ./cli/bat.nix
    };
  };

  home.packages = builtins.attrValues {
    inherit (pkgs)

      # Packages that don't have custom configs go here

      # TODO: spaces before comment are removed by nixpkgs-fmt
      # See: https://github.com/nix-community/nixpkgs-fmt/issues/305
      borgbackup # backups
      btop # resource monitor
      coreutils # basic gnu utils
      # curl
      eza # ls replacement
      fd # tree style ls
      findutils # find
      fzf # fuzzy search
      jq # JSON pretty printer and manipulator
      nix-tree # nix package tree viewer
      ncdu # TUI disk usage
      pciutils
      pfetch # system info
      pre-commit # git hooks
      p7zip # compression & encryption
      ripgrep # better grep
      usbutils
      tree # cli dir tree viewer
      unzip # zip extraction
      unrar # rar extraction
      wget # downloader
      zip
      nh
      nvd
      nix-output-monitor
      ; # zip compression
  };

  nixpkgs = {
    # overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "repl-flake"
      ];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
