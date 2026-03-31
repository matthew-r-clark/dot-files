{ pkgs, ... }:
let
  # Nord color palette (https://www.nordtheme.com/docs/colors-and-palettes)
  # Polar Night (dark)
  nord0      = "#2E3440"; # darkest gray
  nord0Dark  = "#181E2A"; # custom: darker than nord0, used for inactive panes/background
  nord1      = "#3B4252"; # elevated background, borders
  nord2      = "#434C5E"; # selection
  nord3      = "#4C566A"; # guide markers (lightest polar night)
  # Snow Storm (light)
  nord4      = "#D8DEE9"; # subtext
  nord5      = "#E5E9F0"; # text
  nord6      = "#ECEFF4"; # elevated text
  # Frost (blues)
  nord7      = "#8FBCBB"; # teal accent
  nord8      = "#88C0D0"; # primary action (light blue)
  nord9      = "#81A1C1"; # secondary action (blue)
  nord10     = "#5E81AC"; # tertiary action (dark blue)
  # Aurora
  nord11     = "#BF616A"; # red (error)
  nord12     = "#D08770"; # orange (dangerous)
  nord13     = "#EBCB8B"; # yellow (warning)
  nord14     = "#A3BE8C"; # green (success)
  nord15     = "#B48EAD"; # purple (uncommon)

  # Status bar separators
  sep        = "▏";
  sepRight   = "▕";
  sepCurrent = "▌";
in
{
  programs.tmux = {
    enable = true;
    mouse = true;
    historyLimit = 10000;
    baseIndex = 1;
    terminal = "tmux-256color";
    focusEvents = true;
    sensibleOnTop = false; # we provide our own complete config

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-dir '$HOME/.local/share/tmux/resurrect'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '1'
        '';
      }
    ];

    extraConfig = ''
      set -g default-command $SHELL

      setw -g automatic-rename off
      set -g set-titles on
      setw -g pane-base-index 1

      set -g visual-activity on
      set -g visual-bell off
      set -g visual-silence on
      set -g bell-action none
      setw -g monitor-activity off

      set -g renumber-windows on
      set -w -g wrap-search off

      set -ga terminal-overrides '*:RGB:Ss=\E[%p1%d q:Se=\E[ q'

      bind-key c new-window -c ~/development/taillight

      # is_vim: used for resize keybindings and C-e clear; C-hjkl nav is handled by vim-tmux-navigator plugin
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

      # C-e sends C-l (clear screen) when not in vim
      bind-key -n 'C-e' if-shell "$is_vim" 'send-keys C-e' 'send-keys C-l'

      # Split panes, preserving current path
      bind-key v split-window -h -c "#{pane_current_path}"
      bind-key h split-window -v -c "#{pane_current_path}"

      # Smart pane resizing with vim awareness
      bind-key -n 'M-k' if-shell "$is_vim" 'send-keys M-k' 'resize-pane -U 5'
      bind-key -n 'M-h' if-shell "$is_vim" 'send-keys M-h' 'resize-pane -L 5'
      bind-key -n 'M-j' if-shell "$is_vim" 'send-keys M-j' 'resize-pane -D 5'
      bind-key -n 'M-l' if-shell "$is_vim" 'send-keys M-l' 'resize-pane -R 5'

      # Window navigation
      bind-key C-h swap-window -t -1 \; select-window -t -1
      bind-key C-l swap-window -t +1 \; select-window -t +1
      bind-key C-p select-window -t -1
      bind-key C-n select-window -t +1
      # use prefix + ' to jump to a window by index

      # ---------------------------------------------------------------------------
      # Nord theme — status bar
      # ---------------------------------------------------------------------------
      set -g window-status-separator '''
      set -g status on
      set -g status-interval 1
      set -g status-style                    "bg=${nord0Dark}"
      set -g message-style                   "bg=${nord15},fg=${nord0Dark}"
      set -g window-style                    "bg=${nord0}"
      set -g window-active-style            "bg=${nord0Dark}"
      set -g pane-border-style               "fg=${nord0Dark},bg=${nord0Dark}"
      set -g pane-active-border-style        "fg=${nord0Dark},bg=${nord0Dark}"
      set -g status-left  "#{?client_prefix,#[bg=${nord0Dark}#,fg=${nord15}],#[bg=${nord0Dark}#,fg=${nord4}]} #{?client_prefix,prefix,#S} "
      set -g status-right "%H:%M:%S #[fg=${nord8},bg=${nord0Dark}]#[bg=${nord8},fg=${nord0Dark}] %b %d "
      setw -g window-status-format         "#[fg=${nord0Dark},bg=${nord3}]  #I #W #[fg=${nord2},bg=${nord3}]${sepRight}"
      setw -g window-status-current-format "#[bg=${nord0Dark},fg=${nord8}]${sepCurrent} #I #W ${sepRight}"
    '';
  };
}
