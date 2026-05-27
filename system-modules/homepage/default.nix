{pkgs, lib, config, ...}: {
  sops.secrets.homepage-secrets = {
    uid = 
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
        "Services" = [
          {
            "Jellyfin" = {
              description = "Media server";
              href = "https://jellyfin.snack.management";
              siteMonitor = "https://jellyfin.snack.management";
              widget = {
                type = "jellyfin";
                url = "https://jellyfin.snack.management";
                key = "{{HOMEPAGE_VAR_JELLYFIN}}";
                version = 1;
                enableBlocks = true;
                enableNowPlaying = true;
                enableUser = true;
                enableEpisodeNumber = true;
              };
            };
          }
          {
            "Home Assistant" = {
              description = "Home automation";
              href = "https://hass.snack.management";
            };
          }
          {
            "Paperless NGX" = {
              description = "Document Management";
              href = "https://paperless.snack.management";
            };
          }
          {
            "Nextcloud" = {
              description = "Cloud Storage and File Syncing";
              href = "https://cloud.snack.management";
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
