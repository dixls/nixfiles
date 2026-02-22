{ config, pkgs, inputs, ... }:
{
  imports = [
    ./plex-nginx.nix
    ./jellyfin-nginx.nix
    # ./synapse-nginx.nix
  ];

  networking = {
    firewall = {
      allowedTCPPorts = [
        80
        443
      ];
    };
  };

  services.cloudflare-dyndns = {
    enable = true;
    domains = [
      "snack.management"
      "acme.snack.management"
    ];
    apiTokenFile = config.sops.secrets."cftoken".path;
    ipv4 = true;
    proxied = true;
  };
  
  security.acme = {
    acceptTerms = true;
    defaults.email = "admin+acme@snack.management";
    certs."snack.management" = {
      domain = "*.snack.management";
      dnsProvider = "cloudflare";
      group = "nginx";
      environmentFile = config.sops.secrets."snack-management".path;
      dnsPropagationCheck = true;
    };
  };

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = let
      base = locations: {
        inherit locations;

        forceSSL = true;
        useACMEHost = "snack.management";
      };
      ortus = port: base {
        "/" = {
          proxyPass = "http://192.168.1.6:" + toString(port) + "/";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };
      gideon = port: base {
        "/" = {
          proxyPass = "http://192.168.1.7:" + toString(port) + "/";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };
      mercymorn = port: base {
        "/" = {
          proxyPass = "https://192.168.1.12:" + toString(port) + "/";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };
      john = port: base {
        "/" = {
          proxyPass = "http://192.168.1.8:" + toString(port) + "/";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };
      hass = port: base {
        "/" = {
          proxyPass = "http://192.168.1.80:" + toString(port) + "/";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };
    in {
      "truenas.snack.management" = ortus 80;

      "dockge.snack.management" = john 5001;
      "prowlarr.snack.management" = john 9696;
      "sonarr.snack.management" = john 8989;
      "radarr.snack.management" = john 7878;
      "qbittorrent.snack.management" = john 8082;
      "overseerr.snack.management" = john 5055;
      
      "audiobooks.snack.management" = gideon 8000;
      "paperless.snack.management" = gideon 28981;
      "immich.snack.management" = {
        useACMEHost = "snack.management";
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://192.168.1.7:2283";
          proxyWebsockets = true;
          recommendedProxySettings = true;
          extraConfig = ''
            client_max_body_size 50000M;
            proxy_read_timeout   600s;
            proxy_send_timeout   600s;
            send_timeout         600s;
          '';
        };
      };
      # "cloud.snack.management" = {
      #   useACMEHost = "snack.management";
      #   forceSSL = true;
      #   locations."/" = {
      #     proxyPass = "http://192.168.1.7:80";
      #     proxyWebsockets = true;
      #     recommendedProxySettings = true;
      #     extraConfig = ''
      #       index index.php index.html /index.php$request_uri;
      #       add_header X-Content-Type-Options nosniff;
      #       add_header X-Robots-Tag "noindex, nofollow";
      #       add_header X-Permitted-Cross-Domain-Policies none;
      #       add_header X-Frame-Options sameorigin;
      #       add_header Referrer-Policy no-referrer;
      #       client_max_body_size 1G;
      #       fastcgi_buffers 64 4K;
      #       fastcgi_hide_header X-Powered-By;
      #       # mirror upstream htaccess file https://github.com/nextcloud/server/blob/v32.0.0/.htaccess#L40-L41
      #       fastcgi_hide_header Referrer-Policy;
      #       fastcgi_hide_header X-Content-Type-Options;
      #       fastcgi_hide_header X-Frame-Options;
      #       fastcgi_hide_header X-Permitted-Cross-Domain-Policies;
      #       fastcgi_hide_header X-Robots-Tag;
      #       gzip on;
      #       gzip_vary on;
      #       gzip_comp_level 4;
      #       gzip_min_length 256;
      #       gzip_proxied expired no-cache no-store private no_last_modified no_etag auth;
      #       gzip_types application/atom+xml text/javascript application/javascript application/json application/ld+json application/manifest+json application/rss+xml application/vnd.geo+json application/vnd.ms-fontobject application/wasm application/x-font-ttf application/x-web-app-manifest+json application/xhtml+xml application/xml font/opentype image/bmp image/svg+xml image/x-icon text/cache-manifest text/css text/plain text/vcard text/vnd.rim.location.xloc text/vtt text/x-component text/x-cross-domain-policy;
      #     '';
      #   };
      # };


      "hass.snack.management" = hass 8123;
      "music.snack.management" = hass 8095;

      "omada.snack.management" = mercymorn 8043;

      "acme.snack.management" = {
        forceSSL = true;
        useACMEHost = "snack.management";
        #enableACME = true;
      };

      # Hosts
      "erebos.snack.management" = {
        forceSSL = true;
        useACMEHost = "snack.management";
        locations."/" = {
          proxyPass = "https://192.168.1.5:8006";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };
      "snack-can.snack.management" = {
        forceSSL = true;
        useACMEHost = "snack.management";
        locations."/" = {
          proxyPass = "https://192.168.1.15:8006";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };
      "palamedes.snack.management" = {
        forceSSL = true;
        useACMEHost = "snack.management";
        locations."/" = {
          proxyPass = "http://192.168.1.16";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };

      # localhost (harrowhark)
      "id.snack.management" = {
        forceSSL = true;
        useACMEHost = "snack.management";
        locations."/" = {
          proxyPass = "http://0.0.0.0:1411";
          proxyWebsockets = true;
          recommendedProxySettings = true;
          extraConfig = ''
            proxy_busy_buffers_size   512k;
            proxy_buffers   4 512k;
            proxy_buffer_size   256k;
          '';
        };
      };
      "kuma.snack.management" = {
        forceSSL = true;
        useACMEHost = "snack.management";
        locations."/" = {
          proxyPass = "http://0.0.0.0:3001";
          proxyWebsockets = true;
          recommendedProxySettings = true;
          extraConfig = ''
            proxy_set_header   X-Real-IP $remote_addr;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   Host $host;
            proxy_set_header   Upgrade $http_upgrade;
            proxy_set_header   Connection "upgrade";
          '';
        };
      };
    };
  };
}
