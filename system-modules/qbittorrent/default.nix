{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    qbittorrent-nox
  ];

  # networking = {
  #   firewall = {
  #     allowedTCPPorts = [ 8080 ];
  #   };
  # };

  # services.qbittorrent = {
  #   enable = true;
  #   torrentingPort = config.sops.secrets."pia-port".path;
  #   openFirewall = true;
  # };
}
