{ pkgs, ... }:
let
  extensions =  with pkgs.gnomeExtensions; [
    appindicator
    caffeine
    auto-move-windows
    moveclock
    tiling-shell
    clipboard-indicator
    notification-banner-reloaded
    # pop-shell
    blur-my-shell
    hot-edge
    tweaks-in-system-menu
  ];
  packages = with pkgs; [
    gnome-tweaks
    ddcutil
  ];
in 
{
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm = {
    enable = true;
    # wayland = true;
  };
  services.desktopManager.gnome.enable = true;
  # services.xserver.displayManager.defaultSession = "gnome";

  environment.gnome.excludePackages = (with pkgs; [
    # for packages that are pkgs.*
    gnome-tour
    gedit
    atomix
    epiphany
    gnome-music
    gnome-terminal
    hitori
    iagno
    tali
    totem
  ]);

  environment.systemPackages = packages ++ extensions;

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  boot.kernelModules = ["i2c-dev"];
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  # services.xserver.displayManager.gdm.wayland = false;

  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "pixls";
  # systemd.services."gett@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;
}
