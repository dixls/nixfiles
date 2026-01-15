{ pkgs, inputs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
    vesktop
    zoom-us
    obsidian
    chromium
    plexamp
    vial
    # kicad
    vlc
    gimp3
    darktable
    inkscape-with-extensions

    gutenprint
    gutenprintBin

    prusa-slicer

    hugo
  ];

  imports = [
    ./desktop
  ];

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # vial udev rule
  # boxflat udev rule?
  services.udev = {
    extraRules = ''
      # vial udev rule
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"

      # should enable boxflat but not working
      SUBSYSTEM=="tty", KERNEL=="ttyACM*", ATTRS{idVendor}=="346e", ACTION=="add", MODE="0666", TAG+="uaccess"
    '';
  };
}
