{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    # ./mastodon
    ./nginx
    # ./keycloak
    ./kuma
    ./pocket-id
    ./matrix-synapse
    # ./servarr
    # ./pia
    # ./qbittorrent
    # ./deluge
    # ./podman
  ];

  sops.secrets."harrowhark-cftunnel" = {};

  services.cloudflared = {
    enable = true;
    tunnels = {
      "e0746225-5593-46ba-937f-2b03c09d2409" = {
        credentialsFile = "${config.sops.secrets.harrowhark-cftunnel.path}";
        default = "http_status:404";
      };
    };
  };
}
