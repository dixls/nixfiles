{config, pkgs, inputs, ...}:
{
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
