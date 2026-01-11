{pkgs, inputs, ...}: {
  imports = [
    # ./mastodon
    # ./bluesky
    # ./httpecho.nix # Basically just to test podman is working
    ./gluetun
    # ./qbittorrent
    # ./servarr
  ];
}
