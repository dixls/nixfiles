{ config, pkgs, inputs, authentik-nix, ... }:
{
  services.authentik = {
    enable = true;
    environmentFile = config.sops.secrets.authentik-env.path;
    nginx = {
      enable = true;
      enableACME = true;
      host = "auth.snack.management";
    };
    settings = {
      email = {
        use_tls = true;
        use_ssl = false;
        from = "authentik@snack.management";
      };
    };
  };
}

