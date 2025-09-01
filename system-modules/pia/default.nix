{ config, pkgs, inputs, ... }: {
  # services.pia.enable = true;

  # # Hardcoded username and password
  # services.pia.authUserPass.username = config.sops.secrets."pia-username".path;
  # services.pia.authUserPass.password = config.sops.secrets."pia-password".path;

  # Alternatively, you can use the `authUserPassFile` attribute if you are using
  # a Nix secrets manager. Here's an example using sops-nix.
  #
  # The secret you provide to `authUserPassFile` should be a multiline string with
  # a single username on the first line a single password on the second line.
  # services.pia.authUserPassFile = config.sops.secrets.pia.path;

  environment.systemPackages = with pkgs; [
    openvpn
  ];

  systemd.services.pia = {
    enable = true;
    description = "pia vpn via openvpn";
    path = [
      pkgs.openvpn
    ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.openvpn}/bin/openvpn --config ${config.sops.templates."pia-config".path} --auth-user-pass ${config.sops.secrets."pia-creds".path}
      '';
    };
  };
}
