{ config, pkgs, inputs, ... }:
let
  tmux-nova = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-nova";
    version = "1.2.0";
    src = pkgs.fetchFromGitHub {
      owner = "o0th";
      repo = "tmux-nova";
      rev = "6c8fc10d3daa03f400ea9000f9321d8332eab229";
      sha256 = "16llz3nlyw88lyd8mmj27i0ncyhpfjj5c1yikngf7nxcqsbjmcnh";
    };
  };
in 
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
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmux-nova
    ];
    extraConfig = ''
      set-option -g status-position top
      set-option -ga terminal-overrides ',foot:Tc'

      unbind r
      bind r source-file ~/.config/tmux/tmux.conf
      set -g @nova-nerdfonts true
      set -g @nova-nerdfonts-left 
      set -g @nova-nerdfonts-right 
      
      foreground="#E9E0D2"
      dark_bg="#08211B"
      light_pink="#F5CABF"
      light_green="#7AB49D"
      dark_green="#1F4E43"
      light_teal="#82B0A5"

      set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
      set -g @nova-segment-mode-colors "$light_pink $dark_bg"
      
      set -g @nova-segment-whoami "#(whoami)@#h"
      set -g @nova-segment-whoami-colors "$light_pink $dark_bg"
      
      set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"
      
      set -g @nova-rows 0
      set -g @nova-segments-0-left "mode"
      set -g @nova-segments-0-right "whoami"

      set -g @nova-pane-active-border-style "$light_teal"
      set -g @nova-pane-border-style "$dark_bg"
      set -g @nova-status-style-bg "$dark_bg"
      set -g @nova-status-style-fg "$light_green"
      set -g @nova-status-style-active-bg "$dark_green"
      set -g @nova-status-style-active-fg "$foreground"
      set -g @nova-status-style-double-bg "$dark_green"
    '';
  };
} 
