{ config,pkgs, input, lib, ... }:

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
    ../../users/pixls.nix

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

  fileSystems."/mnt/snack-pool" = {
    device = "//192.168.1.22/snack-pool";
    fsType = "cifs";
    options = [
      "x-systemd.automount" "noauto"
      "credentials=${config.sops.secrets."pixls-samba".path}"
    ];
  };

  networking = {
    networkmanager.enable = true;
    interfaces.wlp5s0.wakeOnLan.enable = true;
  };
  
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fantasque-sans-mono
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
