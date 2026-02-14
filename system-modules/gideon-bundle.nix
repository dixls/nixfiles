{pkgs, lib, config, ...}: {
  imports = [
    # ./mastodon
    # ./nginx
    ./podman
    ./matrix-synapse
    # ./ocis
    ./nextcloud
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
