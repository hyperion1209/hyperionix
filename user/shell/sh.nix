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
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    initExtra = ''
    PROMPT="%{$fg[cyan]%}[%~] $program %{$fg[default]%}
%B%{$fg[blue]%}[%{$fg[yellow]%}%n%{$fg[red]%}@%{$fg[yellow]%}%m%{$fg[blue]%}] %(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜)%{$reset_color%}"
    [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
    '';
  };
}
