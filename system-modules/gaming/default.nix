{ pkgs, inputs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
  # steam
  lutris
  bubblewrap
  ];
  programs.steam = {
    enable = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
    gamescopeSession.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };
}
