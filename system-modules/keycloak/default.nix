{ config, pkgs, ... }: {
  services.keycloak = {
    enable = true;
    settings = {
      hostname = "auth.snack.management";
      hostname-backchannel-dynamic = true;
    };
  };
}
