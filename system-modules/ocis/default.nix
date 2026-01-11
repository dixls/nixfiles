{ config, pkgs, inputs, ... }:
{
  services.ocis = {
    enable = true;
    stateDir = "/ortus/files/ocis";
    url = "https://cloud.snack.management";
  };

  networking = {
     firewall = {
       allowedTCPPorts = [
         config.services.ocis.port
       ];
     };
   };

  users.users.ocis = {
    uid = 333;
  };

  fileSystems."/ortus" = {
    device = "//192.168.1.6/subvol-101-disk-0";
    fsType = "cifs";
    options = [
      "x-systemd.automount" "noauto"
      "credentials=${config.sops.secrets."gideon-samba".path}"
      "uid=333"
    ];
  };
}
