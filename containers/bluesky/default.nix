{ pkgs, ... }:
{
  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers = {
    bluesky-pds = {
      image = "ghcr.io/bluesky-social/pds:0.4";
      restart = "unless-stopped";
      ports = [ "127.0.0.1:3000:3000" ];
      volumes = [
        "/etc/pds/data:/pds"
      ];
      env_file = [
        "/etc/pds/pds.env"
      ];
    };
  };

  environment.etc = {
    "pds/pds.env".source = ./../../secrets/pds.env
  };
}
