{ pkgs, ...}:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    historyLimit = 100000;
    keyMode = "vi";
    shortcut = "Space";
    terminal = "screen-256color";
    mouse = true;
    newSession = true;
    extraConfig = ''
      unbind ^\
      
      unbind %
      bind | split-window -h

      unbind '"'
      bind - split-window -v

      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D 
      bind k select-pane -U
      bind l select-pane -R

      # Resize a tmux pane
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      # Maximize a tmux pane
      bind -r m resize-pane -Z

      set-window-option -g mode-keys vi

      # start selecting text with "v"
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle

      # copy text with "y"
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

      # don't exit copy mode after dragging with mouse
      unbind -T copy-mode-vi MouseDragEnd1Pane

      set -g @resurrect-strategy-nvim 'session'"
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '15' # minutes
    '';
    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.gruvbox
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
    ];
  };
}
