{ pkgs, ... }:
{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    plasma-browser-integration
    oxygen
  ];
}
