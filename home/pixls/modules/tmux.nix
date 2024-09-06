{ pkgs, unstable, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    historyLimit = 100000;
    baseIndex = 1;
    mouse = true;
    keyMode = "vi";
    prefix = "C-s";
    plugins = with unstable; [
      tmuxPlugins.vim-tmux-navigator
      # {
      #   plugin = tmuxPlugins.tmux-nova;
      #   extraConfig = ''
      #     set -g @nova-nerdfonts true
      #     set -g @nova-nerdfonts-left 
      #     set -g @nova-nerdfonts-right 
      #     
      #     foreground="#E9E0D2"
      #     dark_bg="#08211B"
      #     light_pink="#F5CABF"
      #     light_green="#7AB49D"
      #     dark_green="#1F4E43"
      #     light_teal="#82B0A5"

      #     set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
      #     set -g @nova-segment-mode-colors "$light_pink $dark_bg"
      #     
      #     set -g @nova-segment-whoami "#(whoami)@#h"
      #     set -g @nova-segment-whoami-colors "$light_pink $dark_bg"
      #     
      #     set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"
      #     
      #     set -g @nova-rows 0
      #     set -g @nova-segments-0-left "mode"
      #     set -g @nova-segments-0-right "whoami"

      #     set -g @nova-pane-active-border-style "$light_teal"
      #     set -g @nova-pane-border-style "$dark_bg"
      #     set -g @nova-status-style-bg "$dark_bg"
      #     set -g @nova-status-style-fg "$light_green"
      #     set -g @nova-status-style-active-bg "$dark_green"
      #     set -g @nova-status-style-active-fg "$foreground"
      #     set -g @nova-status-style-double-bg "$dark_green"
      #   '';
      # }
    ];
    extraConfig = ''
      set-option -g status-position top
      set-option -ga terminal-overrides ',alacritty:Tc'

      unbind r
      bind r source-file ~/.config/tmux/tmux.conf
    '';
  };
} 
