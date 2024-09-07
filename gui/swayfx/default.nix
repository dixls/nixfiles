{ pkgs, ... }:

{
  programs.sway = {
    enable = true;
    wrapperFreatures.gtk = true;
    package = pkgs.swayfx;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako
      grim
      slurp
      alacritty
      wofi
      dmenu
      configure-gtk
      xdg-utils
    ];
  };

  programs.waybar.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_sessions = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };
}
