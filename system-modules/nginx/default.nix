{ config, pkgs, inputs, ... }:
{
  imports = [
    # ./plex-nginx.nix
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
      "overseerr.snack.management"
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
          proxyPass = "http://192.168.1.12:" + toString(port) + "/";
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
      "audiobooks.snack.management" = gideon 8000;
      "overseerr.snack.management" = john 5055;
      "plex.snack.management" = gideon 32400;
      "hass.snack.management" = hass 8123;
      "music.snack.management" = hass 8095;
      "omada.snack.management" = mercymorn 8043;
      "acme.snack.management" = {
        forceSSL = true;
        useACMEHost = "snack.management";
        #enableACME = true;
      };
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
    };
  };
}
