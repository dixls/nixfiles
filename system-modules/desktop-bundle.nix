{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
    steam
    zoom-us
    obsidian
    chromium
    plexamp
    vial

    gutenprint
    gutenprintBin

    prusa-slicer

    hugo
  ];
}
