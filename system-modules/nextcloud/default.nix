{config, lib, pkgs, ...}:
let
  domain = "cloud.snack.management";
in 
{

  networking = {
    firewall = {
      allowedTCPPorts = [
        80
      ];
    };
  };
  
  sops.secrets."nextcloud-admin-pass" = {};
  sops.secrets."snack-management_cert" = {
    owner = config.users.users.nginx.name;
    group = config.users.users.nginx.group;
  };
  sops.secrets."snack-management_pk" = {
    owner = config.users.users.nginx.name;
    group = config.users.users.nginx.group;
  };

  services.nginx.virtualHosts.${domain} = {
    sslCertificate = config.sops.secrets."snack-management_cert".path;
    sslCertificateKey = config.sops.secrets."snack-management_pk".path;
    forceSSL = true;
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    hostName = domain;
    https = true;
    configureRedis = true;
    maxUploadSize = "1G";
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminuser = "admin";
      adminpassFile = config.sops.secrets."nextcloud-admin-pass".path;
      defaultPhoneRegion = "US";
    };
    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit user_oidc calendar contacts;
    };
    settings = {
      trustedProxies = [ "192.168.1.9" ];
      trustedDomains = [ "192.168.1.7:80" ];
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
