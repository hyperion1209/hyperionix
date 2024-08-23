{ config, pkgs, ... }:
let
  myAliases = {
    ll = "ls -lh";
    la = "ls -lah";
    ".." = "cd ..";
    grep = "grep --color=auto";
    egrep = "egrep --color=auto";
    fgrep = "fgrep --color=auto";
    ls = "ls --color=auto";
    df = "df -h";     # human-readable sizes
    free = "free -m"; # show sizes in MB
    psmem = "ps auxf | sort -nr -k 4 | head -5";
    pscpu = "ps auxf | sort -nr -k 3 | head -5";
  };
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    shellAliases = myAliases;

    history = {
      size = 10000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";
      ignorePatterns = ["rm *" "pkill *" "cp *"];
    };

    sessionVariables = {
      EDITOR="nvim";
      TERMINAL="alacritty";
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

    initExtraBeforeCompInit = ''
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)               # Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz vcs_info
autoload -Uz colors && colors

# enable only git
zstyle ':vcs_info:*' enable git

# setup a hook that runs before every ptompt.
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# add a function to check for untracked files in the directory.
# from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
#
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:git:*' formats " %r/%S %b %m%u%c "
zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})"

# format our main prompt for hostname current folder, and permissions.
PROMPT="%{$fg[cyan]%}[%~] $program %{$fg[default]%}
%B%{$fg[blue]%}[%{$fg[yellow]%}%n%{$fg[red]%}@%{$fg[yellow]%}%m%{$fg[blue]%}] %(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜)%{$reset_color%}"
[ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
PROMPT+="\$vcs_info_msg_0_ "
    '';

    initExtra = ''
# bindkey -e will be emacs mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^[[Z' vi-up-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Key-bindings
bindkey '^[[P' delete-char
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down
bindkey -r "^u"
bindkey -r "^d"

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
    '';
  };

  programs.fzf = {
    enable = true; 
    enableZshIntegration = true;
  };
}
