{ pkgs, ... }: {
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
	"foot.desktop"
      ];
    };
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
