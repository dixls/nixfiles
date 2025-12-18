{ config, pkgs, inputs, authentik-nix, ... }:
{
  services.authentik = {
    enable = true;
    # The environmentFile needs to be on the target host!
    # Best use something like sops-nix or agenix to manage it
    environmentFile = config.sops.secrets.authenik-env.path;
    nginx = {
      enable = true;
      enableACME = true;
      host = "auth.snack.management";
    };
    settings = {
      # not sure i wanna do email this way, depends i guess
      # email = {
      #   host = "smtp.example.com";
      #   port = 587;
      #   username = "authentik.services@snack.supply";
      #   use_tls = true;
      #   use_ssl = false;
      #   from = "authentik@example.com";
      # };
      # disable_startup_analytics = true;
      # avatars = "initials";
    };
  };
}
