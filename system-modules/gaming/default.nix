{ pkgs, inputs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    # steam
    lutris
    bubblewrap
    boxflat

    protonup-qt
    protontricks
    wine

    cameractrls
    obs-studio
  ];
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    gamescopeSession.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
  
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "boxflat-udev-rule";
      text = ''
        # Copyright (c) 2025, Tomasz Pakuła Using Arch BTW
        
        # Add uaccess tag to every Moza (Gudsen) ttyACM device so a user can easily access it
        # without being added to the uucp group. This in turn will make it so EVERY user
        # can access these devices
        SUBSYSTEM=="tty", KERNEL=="ttyACM*", ATTRS{idVendor}=="346e", ACTION=="add", MODE="0666", TAG+="uaccess"
        
        # Add uaccess tag to uinput devices to create virtual joysticks
        SUBSYSTEM=="misc", KERNEL=="uinput", OPTIONS+="static_node=uinput", TAG+="uaccess"
      '';
      destination = "/etc/udev/rules.d/99-boxflat.rules";
    })
  ];
}
