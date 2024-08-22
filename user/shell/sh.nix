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
    # enableCompletion = true;

    shellAliases = myAliases;

    history = {
      size = 10000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";
      ignorePatterns = ["rm *" "pkill *" "cp *"];
    };

    initExtraFirst = ''
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef         # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP
    '';
    initExtra = ''
# Colors
autoload -Uz colors && colors

PROMPT="%{$fg[cyan]%}[%~] $program %{$fg[default]%}
%B%{$fg[blue]%}[%{$fg[yellow]%}%n%{$fg[red]%}@%{$fg[yellow]%}%m%{$fg[blue]%}] %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}"
[ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
    '';
  };

  programs.fzf = {
    enable = true; 
    enableZshIntegration = true;
  };
}
