{ config, builtins, lib, pkgs, inputs, ... }:

{
  sops = {
    defaultSopsFile = ../secrets.yaml;
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host-ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      "smtp-password" = {};
      "sweet-samba" = {};
      "savory-samba" = {};
      "pixls-samba" = {};
      "gideon-samba" = {};
      "mercymorn-samba" = {};
      "harrowhark-samba" = {};
      "qbittorrent" = {};
      "pia-username" = {};
      "pia-password" = {};
      "pia-creds" = {};
      "radarr-key" = {};
      "sonarr-key" = {};
      "pia-crl" = {};
      "pia-ca" = {};
      "pia-network" = {};
      "pia-port" = {};
      "snack-management" = {};
      "cftoken" = {};
    };
    templates."pia-config".content = ''
      client
      dev tun
      proto udp
      remote ${config.sops.placeholder."pia-network"} ${config.sops.placeholder."pia-port"}
      resolv-retry infinite
      nobind
      persist-key
      persist-tun
      cipher aes-128-cbc
      auth sha1
      tls-client
      remote-cert-tls server
  
      auth-user-pass
      compress
      verb 1
      reneg-sec 0

      <ca>
      ${config.sops.placeholder."pia-ca"}
      </ca>
  
      disable-occ
    '';
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
    pandoc
    sops

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

    texlive.combined.scheme-minimal
    wkhtmltopdf
  ];
}
