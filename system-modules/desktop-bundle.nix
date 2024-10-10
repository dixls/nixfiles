{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
    steam
    zoom-us
    obsidian

    gutenprint
    gutenprintBin
  ];
}
