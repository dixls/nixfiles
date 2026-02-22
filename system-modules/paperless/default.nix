{pkgs, lib, config, ...}: {

  networking = {
    firewall = {
      allowedTCPPorts = [
        28981
      ];
    };
  };

  secrets.sops."paperless-pocket-id-secret" = {
    owner = ;
    group = ;
  };

  services.paperless = {
    enable = true;
    consumptionDirIsPublic = true;
    address = "0.0.0.0";
    settings = {
      PAPERLESS_CONSUMER_IGNORE_PATTERN = [
        ".DS_STORE/*"
        "desktop.ini"
      ];
      PAPERLESS_OCR_LANGUAGE = "eng";
      PAPERLESS_OCR_USER_ARGS = {
        optimize = 1;
        pdfa_image_compression = "lossless";
      };
      PAPERLESS_URL = "https://paperless.snack.management";
      PAPERLESS_APPS = "allauth.socialaccount.providers.openid_connect";
      PAPERLESS_SOCIALACCOUNT_PROVIDERS = {
        openid_connect = {
          SCOPE = [ "openid" "profile" "email" ];
          OAUTH_PKCE_ENABLED = true;
          APPS = [
            {
              provider_id = "pocket-id";
              name = "Pocket-ID";
              client_id = "e95134e4-1cdb-4d9d-a8c3-9a46a430af42";
              secret = ${config.sops.secrets."paperless-pocket-id-secret"};
              settings = {
                server_url = "https://id.snack.management";
              };
            }
          ];
        };
      };
    };
  };
}
