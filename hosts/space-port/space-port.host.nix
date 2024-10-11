{ pkgs, lib, ... }:

{
  networking = {
    hostName = "space-port";
    firewall = {
      allowPing = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics.enable32Bit = true;

  # Use this to pick which GUI and other bundles
  imports = [
    ./hardware-configuration.nix

    ./../../gui/desktop-defaults.nix
    # ./../../gui/swayfx # this apparently only works from home manager maybe? but some extra bits required
    # ./../../gui/gnome
    ./../../gui/plasma
    # ./../../gui/cosmic

    # other bundles
    #./../system-modules/server-bundle.nix
    ./../../system-modules/desktop-bundle.nix
  ];

  services.openssh.enable = true;

  networking = {
    networkmanager.enable = true;
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

    liquidctl
  ];

  services.hardware.openrgb = {
    package = pkgs.openrgb-with-all-plugins;
    enable = true;
    motherboard = "amd";
  };
  # needed for gigabyte mobo?
  boot.kernelParams = [ "acpi_enforce_resources=lax" ];
}
