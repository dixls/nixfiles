{pkgs, lib, config, ...}: {
  imports = [
    # ./mastodon
    # ./nginx
    ./podman
    # ./ocis

  ];

  sops.secrets."matrix-synapse-reg-secret" = {};
  sops.secrets."snack-management-cftoken" = {};

  networking = {
    firewall = {
      allowedTCPPorts = [
        2283
      ];
    };
  };

  sops.secrets."matrix-cftoken" = {};

  services.cloudflared = {
    enable = true;
    tunnels = {
      "e0746225-5593-46ba-937f-2b03c09d2409" = {
        credentialsFile = "${config.sops.secrets.snack-management-cftoken.path}";
        default = "http_status:404";
      };
    };
  };

  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = "snack.haus";
      public_baseurl = "https://matrix.snack.haus";
      registration_shared_secret = config.sops.secrets."matrix-synapse-reg-secret".path;
      # enable_registration = true;
      # registrations_require_3pid = [ "email" ];
      listeners = [
        {
          port = 8008;
          bind_addresses = [ "::1" ];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [
            { names = [ "client" "federation" ]; compress = true; }
          ];
        }
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
