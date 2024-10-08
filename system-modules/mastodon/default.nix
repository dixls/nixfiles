{ config, pkgs, ... }: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "admin@snack.haus";
  };
  services.mastodon = {
    enable = true;
    localDomain = "snack.haus";
    configureNginx = true;
    smtp.fromAddress = "notifications@snack.haus";
    streamingProcesses = 7;
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
