{ pkgs, ... }:
{
  # this is required for sway, should probably be split out somewhere esle tho

  programs.dconf.enable = true;
  programs.waybar.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.greetd = {
    enable = true;
    settings =  rec {
      initial_session = {
        command = "dbus-run-session ${pkgs.swayfx}/bin/sway";
        user = "pixls";
      };
    };
  };

  # polkit for auth
  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [ polkit_gnome ];
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
