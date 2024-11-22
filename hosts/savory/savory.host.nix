{ pkgs, lib, ... }:

{
  networking = {
    hostName = "savory";
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
    ../../users/pixls.nix

    # ./../gui/desktop-defaults.nix
    # ./../gui/swayfx # this apparently only works from home manager maybe? but some extra bits required
    # ./../gui/gnome
    # ./../gui/plasma

    # other bundles
    ./../../system-modules/server-bundle.nix
  ];

  services.openssh.enable = true;

  fileSystems."/mnt/snack-pool" = {
    device = "//192.168.1.22/snack-pool";
    fsType = "cifs";
    options = [
      "x-systemd.automount" "noauto"
      "credentials=${config.sops.secrets."savory-samba".path}"
    ];
  };

  networking = {
    networkmanager.enable = false;
    interfaces.ens18.useDHCP = true;
    interfaces.ens18.ipv4.addresses = [
      {
        address = "192.168.1.19";
        prefixLength = 24;
      }
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
