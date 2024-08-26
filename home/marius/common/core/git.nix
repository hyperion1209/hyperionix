{
  pkgs,
  lib,
  config,
  configLib,
  configVars,
  ...
}:
let
  handle = configVars.handle;
  username = configVars.username;
  userEmail = configVars.userEmail;
in
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = handle;
    userEmail = userEmail;
    aliases = { };
    extraConfig = {
      init.defaultBranch = "main";
      url = {
        "ssh://git@github.com" = {
          insteadOf = "https://github.com";
        };
        "ssh://git@gitlab.com" = {
          insteadOf = "https://gitlab.com";
        };
      };
    };
    ignores = [
      ".direnv"
      "result"
    ];
  };
}
