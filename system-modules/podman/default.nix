{ config, pkgs, ... }: {

virtualisation = {
  containers = {
    enable = true;
  };
  oci-containers = {
    backend = "podman";
  };
  podman = {
    enable = true;
    dockerCompat = true;
    extraPackages = [ pkgs.zfs ];
    defaultNetwork.settings = {
      dns_enabled = true;
    };
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [
        "--filter=until=24h"
        "--filter=label!=important"
      ];
    };
  };
};

environment.systemPackages = with pkgs; [
  #docker-compose
  podman-compose
];

networking.firewall.interfaces.podman0.allowedUDPPorts = [ 53 ];
networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];
}
