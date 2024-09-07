{ pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackage = (with pkgs; [
    # for packages that are pkgs.*
    gnome-tour
  ]);

  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "pixls";
  systemd.services."gett@tty1".enable = false;
  systemd.servers."autovt@tty1".enable = false;
}
