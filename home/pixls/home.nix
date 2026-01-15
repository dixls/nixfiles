{ config, pkgs, ... }: {
  home.username = "pixls";
  home.homeDirectory = "/home/pixls";

  imports = [
    ./modules
    ./git.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = [
    pkgs.neovim-unwrapped
    pkgs.pyenv
    pkgs.fastfetch
    pkgs.gotop
    pkgs.nvtopPackages.amd

    pkgs.nerd-fonts.fantasque-sans-mono
    pkgs.maple-mono.NF
  ];

  home.file = {
    ".vimrc".source = ./dotfiles/vimrc;
    ".zshrc".source = ./dotfiles/zshrc;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
