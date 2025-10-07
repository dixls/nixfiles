{pkgs, lib, config, ...}: {
  imports = [
    # ./mastodon
    # ./nginx
    # ./podman

  ];

  networking = {
    firewall = {
      allowedTCPPorts = [
        2283
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
    host = "127.0.0.1";
  };

  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    # user = "root";
    # database.user = "postgres";
    # database.name = "immich";
    # mediaLocation = "/mnt/snack-pool/immich/archive";
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
