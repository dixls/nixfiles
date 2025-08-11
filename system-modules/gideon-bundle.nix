_: {
  imports = [
    # ./mastodon

  ];

  services.plex = {
    enable = false;
    openFirewall = true;
    user = "pixls";
  };
}
