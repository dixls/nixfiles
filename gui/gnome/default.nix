{ pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  # I think I want to ditch gnome, or split that out into it's own thing?
  # gonna stick with gnome at least until i get a successful build and boot
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
}
