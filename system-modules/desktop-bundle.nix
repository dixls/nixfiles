{ pkgs, inputs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
    steam
    zoom-us
    obsidian
    chromium
    plexamp
    vial
    # kicad

    gutenprint
    gutenprintBin

    prusa-slicer

    hugo
  ];

  # vial udev rule
  services.udev = {
    extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
  };
}
