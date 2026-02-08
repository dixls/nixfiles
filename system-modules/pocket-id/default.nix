{ config, pkgs, inputs, ... }: {
  sops.secrets."pocket-id-key" = {};

  networking = {
    firewall = {
      allowedTCPPorts = [
        1411
      ];
    };
  };

  services.pocket-id = {
    enable = true;
    settings = {
      TRUST_PROXY = true;
      APP_URL = "https://id.snack.management";
      ANALYTICS_DISABLED = true;
    };
    credentials = {
      ENCRYPTION_KEY = config.sops.secrets."pocket-id-key".path;
    };
  };
}
