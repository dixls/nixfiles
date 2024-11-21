{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
    steam
    zoom-us
    obsidian
    chromium

    gutenprint
    gutenprintBin

    prusa-slicer

    hugo
  ];
}
