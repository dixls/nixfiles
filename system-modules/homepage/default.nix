{pkgs, lib, config, ...}: {
  sops.secrets.homepage-secrets = {
    uid = 0;
    gid = 100;
  };

  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    allowedHosts = "192.168.1.7:8082";
    environmentFiles = [ config.sops.secrets.homepage-secrets.path ];

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
        "Infrastructure" = [
          {
            "OPNSense" = {
              description = "Firewall and router";
              icon = "opnsense.png";
              href = "https://opnsense.snackhaus";
              widget = {
                type = "truenas";
                url = "https://opnsense.snackhaus";
                username = "{{HOMEPAGE_VAR_OPNSENSE_USERNAME}}";
                password = "{{HOMEPAGE_VAR_OPNSENSE_PASSWORD}}";
              };
            };
          }
          {
            "Omada Controller" = {
              description = "Control Panel for Omada networking equipment";
              icon = "omada.png";
              href = "https://omada.snack.management";
              widget = {
                type = "omada";
                url = "https://omada.snack.management";
                username = "{{HOMEPAGE_VAR_OMADA_USERNAME}}";
                password = "{{HOMEPAGE_VAR_OMADA_PASSWORD}}";
                site = "froghaus";
              };
            };
          }
          {
            "Uptime Kuma" = {
              description = "Uptime Monitoring for services";
              icon = "uptime-kuma.png";
              href = "https://kuma.snack.management";
              widget = {
                type = "uptimekuma";
                url = "https://kuma.snack.management";
                slug = "overview";
              };
            };
          }
          {
            "TrueNas" = {
              description = "Storage management";
              icon = "truenas.png";
              href = "https://truenas.snack.management";
              widget = {
                type = "truenas";
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
                version = 2;
                enableBlocks = true;
                enableNowPlaying = true;
                enableUser = true;
                enableEpisodeNumber = true;
              };
            };
          }
          {
            "Audiobookshelf" = {
              description = "Audiobook server and player";
              icon = "audiobookshelf.png";
              href = "https://audiobooks.snack.management";
              widget = {
                type = "audiobookshelf";
                url = "https://audiobooks.snack.management";
                key = "{{HOMEPAGE_VAR_AUDIOBOOKSHELF_KEY}}";
              };
            };
          }
          {
            "Calibre Web" = {
              description = "Ebook library";
              icon = "calibre-web.png";
              href = "https://calibre.snack.management";
              widget = {
                type = "calibreweb";
                url = "https://calibre.snack.management";
                key = "{{HOMEPAGE_VAR_CALIBRE_KEY}}";
              };
            };
          }
          {
            "Immich" = {
              description = "Photo storage";
              icon = "immich.png";
              href = "https://immich.snack.management";
              widget = {
                type = "immich";
                url = "https://immich.snack.management";
                key = "{{HOMEPAGE_VAR_IMMICH_KEY}}";
                version = 2;
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
        ];
      }
      {
        "Downloading" = [
          {
            "Seerr" = {
              description = "Download request and management";
              icon = "seerr.png";
              href = "https://seerr.snack.management";
              widget = {
                type = "seerr";
                url = "https://seerr.snack.management";
                key = "{{HOMEPAGE_VAR_SEERR_KEY}}";
                enableQueue = true;
              };
            };
          }
          {
            "Prowlarr" = {
              description = "Indexer management";
              icon = "prowlarr.png";
              href = "https://prowlarr.snack.management";
              widget = {
                type = "prowlarr";
                url = "https://prowlarr.snack.management";
                key = "{{HOMEPAGE_VAR_PROWLARR_KEY}}";
                enableQueue = true;
              };
            };
          }
          {
            "Radarr" = {
              description = "Movie indexing and downloading";
              icon = "radarr.png";
              href = "https://radarr.snack.management";
              widget = {
                type = "radarr";
                url = "https://radarr.snack.management";
                key = "{{HOMEPAGE_VAR_RADARR_KEY}}";
                enableQueue = true;
              };
            };
          }
          {
            "Sonarr" = {
              description = "TV Series indexing and downloading";
              icon = "sonarr.png";
              href = "https://sonarr.snack.management";
              widget = {
                type = "sonarr";
                url = "https://sonarr.snack.management";
                key = "{{HOMEPAGE_VAR_SONARR_KEY}}";
                enableQueue = true;
              };
            };
          }
          {
            "slskd" = {
              description = "soulseek";
              icon = "slskd.png";
              href = "https://slsk.snack.management";
              widget = {
                type = "slskd";
                url = "https://slsk.snack.management";
                key = "{{HOMEPAGE_VAR_SLSK_KEY}}";
                enableQueue = true;
              };
            };
          }
          {
            "qBittorrent" = {
              description = "Bittorrent client";
              icon = "qbittorrent.png";
              href = "https://qbittorrent.snack.management";
              widget = {
                type = "qbittorrent";
                url = "https://qbittorrent.snack.management";
                username = "{{HOMEPAGE_VAR_QBITTORRENT_USERNAME}}";
                password = "{{HOMEPAGE_VAR_QBITTORRENT_PASSWORD}}";
                enableQueue = true;
              };
            };
          }
        ];
      }
    ];

  };
}
