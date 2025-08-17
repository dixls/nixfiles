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
      config = ''
        client
        dev tun
        proto udp
        remote ${config.sops.secrets."pia-network".path} ${config.sops.secrets."pia-port".path}
        resolv-retry infinite
        nobind
        persist-key
        persist-tun
        cipher aes-128-cbc
        auth sha1
        tls-client
        remote-cert-tls server
  
        auth-user-pass
        compress
        verb 1
        reneg-sec 0
  
        # These settings was included directly in the file from
        # the generator, but I moved them to external files.
        crl-verify ${config.sops.secrets."pia-crl".path}
        ca ${config.sops.secrets."pia-ca".path}
  
        disable-occ
      '';
    };
  };
}
