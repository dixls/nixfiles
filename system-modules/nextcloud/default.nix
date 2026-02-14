{config, lib, pkgs, ...}:
{

  networking = {
    firewall = {
      allowedTCPPorts = [
        8080
      ];
    };
  };
  
  sops.secrets."nextcloud-admin-pass" = {};

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    hostName = "cloud.snack.management";
    https = true;
    configureRedis = true;
    maxUploadSize = "1G";
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = config.sops.secrets."nextcloud-admin-pass".path;
      defaultPhoneRegion = "US";
    };
    settings = {
      enabledPreviewProviders = [
        "OC\\Preview\\BMP"
        "OC\\Preview\\GIF"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\Krita"
        "OC\\Preview\\MarkDown"
        "OC\\Preview\\MP3"
        "OC\\Preview\\OpenDocument"
        "OC\\Preview\\PNG"
        "OC\\Preview\\TXT"
        "OC\\Preview\\XBitmap"
        "OC\\Preview\\HEIC"
      ];
    };
  };
}
