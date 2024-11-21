{ config, builtins, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix-nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../../../secrets.yaml;
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      "smtp-password" = {};
      "sweet-samba" = {};
      "savory-samba" = {};
      "pixls-samba" = {};
    };
  };


  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.optimise.automatic = true;
  nix.optimise.dates = ["weekly"];

  system.autoUpgrade = {
    enable = true;
    flags = [
      "--update-input"
    ];
    dates = "05:00";
    randomizedDelaySec = "45min";
  };

  services.openssh = {
    enable = lib.mkDefault true;
    settings = {
      PasswordAuthentication = lib.mkDefault false;
      LoginGraceTime = 0;
      PermitRootLogin = "no";
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host-ed25519_key";
        type = "ed25519";
      }
    ];
  };

  security = {
    sudo = {
      enable = lib.mkDefault true;
      wheelNeedsPassword = lib.mkDefault false;
    };
  };

  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = lib.mkDefault true;
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = ["192.168.1.1"];

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

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
  programs.htop.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    lshw
    which
    tree
    eza

    fzf
    fd
    ripgrep

    git
    python3
    postgresql_13
    cmake
    cifs-utils

    zip
    xz
    unzip
    p7zip

    home-manager
  ];
}
