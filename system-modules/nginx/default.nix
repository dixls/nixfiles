{ config, pkgs, inputs, ... }:
{
  imports = [
    ./plex-nginx.nix
  ];
  
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "admin+acme@snack.management";
  security.acme.certs."snack.management" = {
    domain = "*.snack.management";
    dnsProvider = "cloudflare";
    environmentFile = config.sops.secrets."snack-management".path;
    dnsPropagationCheck = false;
  };

  services.nginx = {
    enable = true;

    virtualHosts = let
      base = locations: {
        inherit locations;

        forceSSL = true;
        useACMEHost = "acme.snack.management";
      };
      ortus = port: base {
        "/".proxyPass = "http://192.168.1.6:" + toString(port) + "/";
      };
    in {
      "truenas.snack.management" = ortus 80 // { default = true; };
      "acme.snack.management" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = ["*.snack.management"];
        locations."/" = {
          root = "/var/www";
        };
      };
    };
  };
}
