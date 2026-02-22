{pkgs, lib, config, ...}: {

  networking = {
    firewall = {
      allowedTCPPorts = [
        28981
      ];
    };
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
      PAPERLESS_APPS="allauth.socialaccount.providers.openid_connect";

    };
  };
}
