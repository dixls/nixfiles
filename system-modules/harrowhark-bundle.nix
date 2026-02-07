_: {
  imports = [
    # ./mastodon
    ./nginx
    ./keycloak
    ./kuma
    # ./servarr
    # ./pia
    # ./qbittorrent
    # ./deluge
    # ./podman
  ];

  sops.secrets."snack-management-cftunnel" = {};

  services.cloudflared = {
    enable = true;
    tunnels = {
      "e0746225-5593-46ba-937f-2b03c09d2409" = {
        credentialsFile = "${config.sops.secrets.snack-management-cftunnel.path}";
        default = "http_status:404";
      };
    };
  };
}
