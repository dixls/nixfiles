{ config, pkgs, inputs, ... }:
{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = [
    #pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.kdePackages.qtstyleplugin-kvantum
    pkgs.qt6Packages.qt6ct
    pkgs.plasma-panel-colorizer  
    #pkgs.libsForQt5.qt5ct
    pkgs.kdePackages.krohnkite
    pkgs.themechanger
    pkgs.kdePackages.kcalc # Calculator
    pkgs.kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    pkgs.kdePackages.kclock # Clock app
    pkgs.kdePackages.kcolorchooser # A small utility to select a color
    pkgs.kdePackages.kolourpaint # Easy-to-use paint program
    pkgs.kdePackages.ksystemlog # KDE SystemLog Application
    pkgs.kdePackages.sddm-kcm # Configuration module for SDDM
    pkgs.kdiff3 # Compares and merges 2 or 3 files or directories
    pkgs.kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
    pkgs.kdePackages.partitionmanager # Optional: Manage the disk devices, partitions and file systems on your computer
    pkgs.# Non-KDE graphical packages
    pkgs.hardinfo2 # System information and benchmarks for Linux systems
    pkgs.vlc # Cross-platform media player and streaming server
    pkgs.wayland-utils # Wayland utilities
    pkgs.wl-clipboard # Command-line copy/paste utilities for Wayland

    inputs.kwin-effects-forceblur.packages.${pkgs.stdenv.hostPlatform.system}.default # Wayland
  ];

  nixpkgs.config.qt6 = {
    enable = true;
    platformTheme = "qt6ct"; 
    style = "kvantum";
  };

  environment.variables.QT_QPA_PLATFORMTHEME = "qt6ct";
  # qt = {
  #   enable = true;
  #   platformTheme = "qt5ct";
  #   style = "kvantum";
  # };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    plasma-browser-integration
    oxygen
  ];

  imports = [
    # ./plasma-manager.nix
  ];
}
