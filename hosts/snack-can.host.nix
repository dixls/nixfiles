{ pkgs, lib, ... }:

{
  networking = {
    hostName = "snack-can";
    firewall = {
      allowPing = true;
      allowedTCPPorts = [ 22 80 443 ];
    };
  };

  # services.xserver.enable = true;

  # Use this to pick which GUI and other bundles
  imports = [
    # ./../gui/desktop-defaults.nix
    # ./../gui/swayfx # this apparently only works from home manager maybe? but some extra bits required
    # ./../gui/gnome
    # ./../gui/plasma

    # other bundles
    ./../system-modules/server-bundle.nix
  ];

  services.openssh.enable = true;

  networking = {
    networkmanager.enable = false;
    interfaces.enp12s0.useDHCP = true;
    interfaces.enp12s0.ipv4.addresses = [
      {
        address = "192.168.1.15";
        prefixLength = 24;
      }
    ];
    interfaces.enp11s0.useDHCP = false;
    interfaces.enp11s0.ipv4.addresses = [
      {
        address = "192.168.1.14";
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
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL/Svq2HyjLSPdngI4JJLqPlDiQdOpkuvWCoeBUGCkv2 pixls@space-cadet" ];
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
