_: {
  imports = [
    # ./mastodon
    # ./nginx

  ];

  services.plex = {
    enable = true;
    openFirewall = true;
    user = "pixls";
  };
}
