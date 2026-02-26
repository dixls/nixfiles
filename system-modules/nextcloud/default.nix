{config, lib, pkgs, ...}:
{

  networking = {
    firewall = {
      allowedTCPPorts = [
        80
        443
      ];
    };
  };

  sops.secrets."nextcloud-admin-pass" = {};

  fileSystems."/snack-files" = {
    device = "//192.168.1.6/files";
    fsType = "cifs";
    options = [
      "x-systemd.automount" "noauto"
      "credentials=${config.sops.secrets."gideon-samba".path}"
      "uid=nextcloud,gid=nextcloud,file_mode=0777,dir_mode=0777"
    ];
  };

  fileSystems."/mnt/snack-files" = {
    device = "192.168.1.6:/mnt/snack-pool/subvol-101-disk-0/files";
    fsType = "nfs";
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    hostName = "cloud.snack.management";
    https = true;
    configureRedis = true;
    maxUploadSize = "1G";
    datadir = "/mnt/snack-files/nextcloud";
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
      allow_local_remote_servers = true;
    };
  };
}
