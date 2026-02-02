{ config, pkgs, inputs, ... }: {

  networking = {
    firewall = {
      allowedTCPPorts = [
        3001
      ];
    };
  };

  services.uptime-kuma = {
    enable = true;
    settings = {
      HOST = "0.0.0.0";
    };
  };
}
