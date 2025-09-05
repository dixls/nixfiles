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
  
  # security.acme.acceptTerms = true;
  # security.acme.defaults.email = "admin+acme@snack.management";
  # security.acme.certs."snack.management" = {
  #   domain = "*.snack.management";
  #   dnsProvider = "cloudflare";
  #   environmentFile = config.sops.secrets."snack-management".path;
  #   dnsPropagationCheck = false;
  # };

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = let
      base = locations: {
        inherit locations;

        # forceSSL = true;
        # useACMEHost = "acme.snack.management";
      };
      ortus = port: base {
        "/".proxyPass = "http://192.168.1.6:" + toString(port) + "/";
      };
      gideon = port: base {
        "/".proxyPass = "http://192.168.1.7:" + toString(port) + "/";
      };
      mercymorn = port: base {
        "/".proxyPass = "http://192.168.1.12:" + toString(port) + "/";
      };
      john = port: base {
        "/".proxyPass = "http://192.168.1.8:" + toString(port) + "/";
      };
      hass = port: base {
        "/".proxyPass = "http://192.168.1.80:" + toString(port) + "/";
      };
    in {
      "truenas.snack.management" = ortus 80;
      "dockge.snack.management" = john 5001;
      "prowlarr.snack.management" = john 9696;
      "sonarr.snack.management" = john 8989;
      "radarr.snack.management" = john 7878;
      "qbittorrent.snack.management" = john 8082;
      "overseerr.snack.management" = john 5055;
      "plex.snack.management" = gideon 32400;
      "hass.snack.management" = hass 8123;
      "music.snack.management" = hass 8095;
      "omada.snack.management" = mercymorn 8043;
      # "acme.snack.management" = {
      #   forceSSL = true;
      #   enableACME = true;
      #   serverAliases = ["*.snack.management"];
      #   locations."/" = {
      #     root = "/var/www";
      #   };
      # };
      "erebos.snack.management" = {
        #forceSSL = true;
        locations."/" = {
          proxyPass = "http://192.168.1.5:8006";
        };
      };
      "snack-can.snack.management" = {
        #forceSSL = true;
        locations."/" = {
          proxyPass = "http://192.168.1.15:8006";
        };
      };
    };
  };
}
