{pkgs, lib, config, ...}: {
  sops.secrets.homepage-secrets = {
    uid = 0;
    gid = 100;
  };

  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    allowedHosts = "192.168.1.7:8082";
    environmentFile = config.sops.secrets.homepage-secrets.path;

    widgets = [
      {
        search = {
          provider = "duckduckgo";
          target = "_blank";
        };
      }
    ];

    services = [
      {
        "Media" = [
          {
            "Jellyfin" = {
              description = "Media server";
              href = "https://jellyfin.snack.management";
              siteMonitor = "https://jellyfin.snack.management";
              icon = "jellyfin.png";
              widget = {
                type = "jellyfin";
                url = "https://jellyfin.snack.management";
                key = "{{HOMEPAGE_VAR_JELLYFIN_KEY}}";
                version = 1;
                enableBlocks = true;
                enableNowPlaying = true;
                enableUser = true;
                enableEpisodeNumber = true;
              };
            };
          }
        ];
      }
      {
        "Services" = [
          {
            "Home Assistant" = {
              description = "Home automation";
              href = "https://hass.snack.management";
              siteMonitor = "https://hass.snack.management";
              icon = "home-assistant.png";
            };
          }
          {
            "Paperless NGX" = {
              description = "Document Management";
              href = "https://paperless.snack.management";
              siteMonitor = "https://paperless.snack.management";
              icon = "paperless-ngx.png";
            };
          }
          {
            "Nextcloud" = {
              description = "Cloud Storage and File Syncing";
              href = "https://cloud.snack.management";
              siteMonitor = "https://cloud.snack.management";
              icon = "nextcloud.png";
            };
          }
          {
            "TrueNas" = {
              description = "Storage management";
              href = "https://truenas.snack.management";
              widget = {
                type = "truenas"
                url = "https://truenas.snack.management";
                version = 2;
                key = "{{HOMEPAGE_VAR_TRUENAS_KEY}}";
                enablePools = true;
              };
            };
          }
        ];
      }
      {
        "Arr etc" = [
          {
            "Sonarr" = {
              description = "TV Series indexing and downloading";
              href = "https://sonarr.snack.management";
            };
          }
        ];
      }
    ];

  };
}
