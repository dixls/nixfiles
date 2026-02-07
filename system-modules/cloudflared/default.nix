{ pkgs, inputs, lib, ... }:
{
  sops.secrets."snack-management-cftoken" = {};

  services.cloudflared = {
    enable = true;
    tunnels = {
      "e0746225-5593-46ba-937f-2b03c09d2409" = {
        credentialsFile = "${config.sops.secrets.snack-management-cftunnel.path}";
        default = "http_status:404";
      };
      "373c7f12-77eb-4e1f-b28b-dadcd2f0e4f8" = {
        credentialsFile = "${config.sops.secrets.snack-haus-cftunnel.path}";
        default = "http_status:404";
      };
    };
  };
}
