{ config, pkgs, inputs, ... }: {
  sops.secrets."pocket-id-key" = {};

  # networking = {
  #   firewall = {
  #     allowedTCPPorts = [
  #       8080
  #     ];
  #   };
  # };

  services.pocket-id = {
    enable = true;
    credentials = {
      ENCRYPTION_KEY = config.sops.secrets."pocket-id-key".path;
    };
    settings = {
      TRUST_PROXY = true;
      APP_URL = "https://auth2.snack.management";
    };
  };
}
