{ config, pkgs, inputs, ... }:
{
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [
    qemu
  ];


}
