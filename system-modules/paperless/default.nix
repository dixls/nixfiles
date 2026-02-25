{pkgs, lib, config, ...}: {

  networking = {
    firewall = {
      allowedTCPPorts = [
        28981
        2049
      ];
    };
  };

  fileSystems."/exports/paperless-ingest" = {
    device = config.services.paperless.consumptionDir;
    options = [ "bind" ];
  };

  services.nfs.server = {
    enable = true;
    exports = ''
      /exports/paperless-ingest   192.168.1.121(rw,nohide,insecure,no_subtree_check)
    '';
  };

  services.paperless = {
    enable = true;
    consumptionDirIsPublic = false;
    address = "0.0.0.0";
    settings = {
      PAPERLESS_CONSUMER_IGNORE_PATTERN = [
        ".DS_STORE/*"
        "desktop.ini"
      ];
      PAPERLESS_OCR_LANGUAGE = "eng";
      PAPERLESS_CONSUMER_POLLING = 60;
      PAPERLESS_TIKA_ENABLED = true;
      PAPERLESS_OCR_USER_ARGS = {
        optimize = 1;
        pdfa_image_compression = "lossless";
      };
      PAPERLESS_URL = "https://paperless.snack.management";
      PAPERLESS_APPS = "allauth.socialaccount.providers.openid_connect";
    };
  };

  services.tika = {
    enable = true;
  };

  services.gotenberg = {
    enable = true;
  };
}
