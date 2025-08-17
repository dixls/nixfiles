{config, pkgs, inputs, ... }:
{
  services.openvpn.servers = {
    pia = {
      autoStart = true;
      authUserPass = {
        username = config.sops.secrets."pia-username".path;
        password = config.sops.secrets."pia-password".path;
      };
      # Most of these options came from the OVPN file from the generator
      config = config.sops.templates."pia-config".path;
    };
  };
}
