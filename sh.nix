{ config, pkgs, ... }:
let
  myAliases = {
    ll = "ls -lh";
    la = "ls -lah";
    ".." = "cd ..";
  };
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    shellAliases = myAliases;
  };
}
