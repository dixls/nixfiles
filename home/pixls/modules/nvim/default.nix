{ config, lib, pkgs, inputs, ... }: 
{
  home.file = {
    "./.config/nvim/" = {
      recursive = true;
      source = ./config;
    };
  };
}
