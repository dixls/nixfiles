{ pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm = {
    enable = true;
    # wayland = true;
  };
  services.xserver.desktopManager.gnome.enable = true;
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

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.auto-move-windows
    gnomeExtensions.moveclock
    gnomeExtensions.tiling-shell
    gnomeExtensions.clipboard-indicator
  ];

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # services.xserver.displayManager.gdm.wayland = false;

  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "pixls";
  # systemd.services."gett@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;
}
