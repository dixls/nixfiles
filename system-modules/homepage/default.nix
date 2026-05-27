{pkgs, lib, config, ...}: {
  services.sops.secrets.jellyfin-homepage-token = {};
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    allowedHosts = "192.168.1.7:8082";


    widgets = [
      {
        search = {
          provider = "duckduckgo";
          target = "_blank";
        }
      }
      {
        jellyfin = {
          url = "https://jellyfin.snack.management";
          key = config.sops.secrets.jellyfin-homepage-token.path;
          version = 2;
          enableBlocks = true;
          enableNowPlaying = true;
          enableUser = true;
          enableEpisodeNumber = true;
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
