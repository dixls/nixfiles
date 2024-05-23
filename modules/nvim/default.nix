{ config, lib, pkgs, inputs, ... }: 
let
  unstable = import inputs.unstablepkgs {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  home.file = {
    "./.config/nvim/" = {
      recursive = true;
      source = ./config;
    };
  };
}
