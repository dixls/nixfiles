{config, pkgs, ...}:
{
  services.qbittorrent = {
    enable = true;
    torrentingPort = config.sops.secrets."pia-port".path;
    openFirewall = true;
  };
}
