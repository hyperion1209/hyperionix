{ osConfig, ... }:
{
  programs.ssh = {
    enable = true;

    extraConfig = ''
    # req'd for enabling yubikey-agent
      AddKeysToAgent yes
    '';

    matchBlocks = {
      "git" = {
        host = "gitlab.com github.com";
        user = "git";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = [
          "~/.ssh/id_${osConfig.networking.hostName}"
        ];
      };
    };
    # FIXME: This should probably be for git systems only?
    # Should create PR for this to be part of MatchBlocks
    controlMaster = "auto";
    controlPath = "~/.ssh/sockets/S.%r@%h:%p";
    controlPersist = "10m";
  };
  home.file.".ssh/sockets/.keep".text = "# Managed by Home Manager";
}
