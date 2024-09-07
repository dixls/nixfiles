{ pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.displayManager.defaultSession = "gnome";

  environment.gnome.excludePackages = (with pkgs; [
    # for packages that are pkgs.*
    gnome-tour
  ]);

  # services.xserver.displayManager.gdm.wayland = false;

  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "pixls";
  # systemd.services."gett@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;
}
