{ config, inputs, pkgs, ... }:
{
  sops.secrets.pixls-password.neededForUsers = true;
  users.mutableUsers = false;

  users.users.pixls = {
    isNormalUser = true;
    description = "pixls";
    hashedPasswordFile = config.sops.secrets.pixls-password.path;
    extraGroups = [ "networkmanager" "wheel" "i2c"];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
    uid = 1000;
    openssh.authorizedKeys.keys = [ 
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL/Svq2HyjLSPdngI4JJLqPlDiQdOpkuvWCoeBUGCkv2 pixls@space-cadet" 
    ];
  }; 
}
