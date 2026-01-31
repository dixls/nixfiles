{ config, pkgs, inputs, ... }: {
  sops.secrets."keycloak-db-pass" = {};

  # networking = {
  #   firewall = {
  #     allowedTCPPorts = [
  #       8080
  #     ];
  #   };
  # };

  services.keycloak = {
    enable = true;
    database.passwordFile = config.sops.secrets."keycloak-db-pass".path;
    settings = {
      hostname = "https://auth.snack.management";
      hostname-backchannel-dynamic = true;
      http-enabled = true;
      http-port = 8080;
    };
  };
}
