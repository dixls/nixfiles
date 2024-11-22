{ config, ...}:
{
  sops.secrets = {
    "smtp/password" = {
      owner = config.users.users.pixls.name;
      inherit (config.users.users.pixls) group;
    };
    "smtp/user" = {
      owner = config.users.users.pixls.name;
      inherit (config.users.users.pixls) group;
    };
  };

  programs.msmtp = {
    enable = true;
    setSendmail = true;

    accounts = {
      "smtp2go" = {
        host = "mail.smtp2go.com";
        from = "snacks@snack.haus";
        to = "dev@snack.supply";
        user = "sweet.snack.haus"}";
        passwordeval = "cat ${config.sops.secrets."smtp-password".path}";
      };
    };
  };
}
