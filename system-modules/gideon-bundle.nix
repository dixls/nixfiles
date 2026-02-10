{pkgs, lib, config, ...}: {
  imports = [
    # ./mastodon
    # ./nginx
    ./podman
    # ./ocis

  ];

  sops.secrets."matrix-synapse-reg-secret" = {};

  networking = {
    firewall = {
      allowedTCPPorts = [
        2283
      ];
    };
  };

  sops.secrets."gideon-cftunnel" = {};

  services.cloudflared = {
    enable = true;
    tunnels = {
      "373c7f12-77eb-4e1f-b28b-dadcd2f0e4f8" = {
        credentialsFile = "${config.sops.secrets.gideon-cftunnel.path}";
        default = "http_status:404";
      };
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

  services.plex = {
    enable = true;
    openFirewall = true;
    user = "pixls";
  };

  services.audiobookshelf = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0";
  };

  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    mediaLocation = "/media/immich/archive";
    openFirewall = true;
    accelerationDevices = null;
  };

  users.users.immich = {
    uid = 222;
    extraGroups = [
      "video"
      "render"
    ];
  };

  fileSystems."/media" = {
    device = "//192.168.1.6/subvol-101-disk-0";
    fsType = "cifs";
    options = [
      "x-systemd.automount" "noauto"
      "credentials=${config.sops.secrets."gideon-samba".path}"
      "uid=222"
    ];
  };
}
