{
  virtualisation.oci-containers.containers = {
    mastodon = {
      image = "lscr.io/linuxserver/mastodon:latest";
      name = "mastodon";
      ports = ["1444:80" "1443:443"];
    };
  };
}
