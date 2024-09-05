{ config, builtins, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "snack-can";

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";


  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    lshw
    which
    tree

    fzf
    fd
    ripgrep

    git
    python3
    postgresql_13
    go

    zip
    xz
    unzip
    p7zip
  ];

  services.openssh.enable = true;
}