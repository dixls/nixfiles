{config, pkgs, inputs, ...}:
{
  networking = {
    firewall = {
      allowedTCPPorts = [ 8112 ];
    };
  };
  services.deluge = {
    enable = true;
    web.enable = true;
    declarative = false;
    config = {
      listen_ports = [ config.sops.secrets."pia-port".path ];
    };
    openFirewall = true;
  };
}
