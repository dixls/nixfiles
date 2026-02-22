{config, lib, pkgs, ...}:
let
  domain = "cloud.snack.management";
in 
{

  networking = {
    firewall = {
      allowedTCPPorts = [
        80
        443
      ];
    };
  };
   
  security.acme = {
    acceptTerms = true;
    defaults.email = "admin+acme@snack.management";
    certs."snack.management" = {
      domain = "cloud.snack.management";
      dnsProvider = "cloudflare";
      group = "nginx";
      environmentFile = config.sops.secrets."snack-management".path;
      dnsPropagationCheck = true;
    };
  }; 

  sops.secrets."nextcloud-admin-pass" = {};

  services.nginx = {
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."cloud.snack.management" = {
      forceSSL = true;
      useACMEHost = "snack.management";
    };
  };

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
      adminuser = "admin";
      adminpassFile = config.sops.secrets."nextcloud-admin-pass".path;
      defaultPhoneRegion = "US";
    };
    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit user_oidc calendar contacts;
    };
    settings = {
      trustedProxies = [ "192.168.1.9" ];
      trustedDomains = [ "192.168.1.7:80" "192.168.1.7:443"];
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
