{ config, pkgs, lib, ... }:
let
  baseDomain = "snack.haus";
  domain = "xmpp.${baseDomain}";
  mucDomain = "conference.${domain}";
  uploadDomain = "upload.${domain}";
  sslCertDir = config.security.acme.certs.${baseDomain}.directory;
in 
{
  services.prosody = {
    enable = true;
    admins = [
      "admin@${baseDomain}"
    ];

    ssl = {
      cert = "${sslCertDir}/fullchain.pem";
      key = "${sslCertDir}/key.pem";
    };

    httpFileShare = {
      domain = uploadDomain;
      uploadFileSizeLimit = 100 * 1024 * 1024;
    };

    muc = [{
      domain = mucDomain;
      name = "chat rooms";
      restrictRoomCreation = false;
    }];

    virtualHosts.${baseDomain} = {
      enabled = true;
      domain = baseDomain;
      ssl = {
        cert = "${sslCertDir}/fullchain.pem";
        key = "${sslCertDir}/key.pem";
      };
    };

    modules = {
      roster     = true;
      saslauth   = true;
      tls        = true;
      dialback   = true;
      disco      = true;
      carbons    = true;
      pep        = true;
      mam        = true;
      ping       = true;
      admin_adhoc= true;
      http_files = true;
    };

    allowRegistration = false;
  };

  users.groups.certs.members = ["prosidy" "nginx" "acme"];

  sops.secrets."snack-haus" = {};

  security.acme = {
    acceptTerms = true;
    defaults.email = "admin@snack.haus";
    certs.${baseDomain} = {
      group = "certs";
      dnsProvider = "cloudflare";
      environmentFile = config.sops.secrets."snack-haus".path;
      dnsPropagationCheck = true;
      postRun = "systemctl reload prosody.service";
      extraDomainNames = [domain mucDomain uploadDomain];
    };
  };
  
  networking.firewall.allowedTCPPorts = [ 5222 5223 ];

}
