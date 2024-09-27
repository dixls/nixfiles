{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
    steam

    gutenprint
    gutenprintBin
  ];
}
