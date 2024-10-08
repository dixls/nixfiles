{ pkgs, lib, ... }:

{
  networking = {
    hostName = "sweet";
    firewall = {
      allowPing = true;
      allowedTCPPorts = [ 22 80 443 ];
    };
  };

  # boot.loader.efi.efiSysMountPoint = "/dev/sda";
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # services.xserver.enable = true;

  # Use this to pick which GUI and other bundles
  imports = [
    ./hardware-configuration.nix

    # ./../gui/desktop-defaults.nix
    # ./../gui/swayfx # this apparently only works from home manager maybe? but some extra bits required
    # ./../gui/gnome
    # ./../gui/plasma

    # other bundles
    ./../../system-modules/server-bundle.nix
    ./../../containers/sweet-budnle.nix

    # ./../../system-modules/mastodon
  ];

  services.openssh.enable = true;

  networking = {
    networkmanager.enable = false;
    interfaces.ens18.useDHCP = true;
    interfaces.ens18.ipv4.addresses = [
      {
        address = "192.168.1.18";
        prefixLength = 24;
      }
    ];
  };

  # Define a user account.
  users.users.pixls = {
    isNormalUser = true;
    description = "pixls";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
    uid = 1000;
    openssh.authorizedKeys.keys = [ 
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL/Svq2HyjLSPdngI4JJLqPlDiQdOpkuvWCoeBUGCkv2 pixls@space-cadet" 
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJBKeJE0SYxkOxtmUmAHMezxWqa9htjMgXbLXHw0qjEc pixls@space-port"
    ];
  }; 
  
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
      noto-fonts
    ];
    fontconfig.defaultFonts.monospace = ["FantasqueSansMono"];
  };

  environment.systemPackages = with pkgs; [
    gcc
    nodejs_22
    go

    foot
  ];
}
