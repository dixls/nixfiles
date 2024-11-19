{config, pkgs, ...}:
{
  services.nginx.enable = true;
  services.nginx.virtualHosts = {
    "snack.haus" = {
      addSSL = true;
      enableACME = true;
      
    };
  };
}
