{ pkgs, inputs, lib, ... }:
{
  imports = [
    # ./gx100.nix
  ];

  environment.systemPackages = with pkgs; [
    # steam
    lutris
    bubblewrap
    # boxflat

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

  # boot.kernelParams = [
  #   "usbhid.quirks=0x04b0:0x5750:0x40000000"
  # ];

  boot.initrd.kernelModules = ["usbhid" "joydev" "xpad"];

  services.udev.extraHwdb = ''
evdev:name:GX100 Shifter:*
  ID_INPUT_JOYSTICK=1

evdev:name:Handbrake:*
  ID_INPUT_JOYSTICK=1
  '';
  
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
    (pkgs.writeTextFile {
      name = "alix-udev-rule";
      text = ''
        # uinput?
        KERNEL=="uinput", MODE="0660", GROUP="input", TAG+="uaccess"


        # Handbrake
        KERNEL=="hidraw*", ATTRS{idVendor}=="0483"\
        ATTRS{idProduct}=="5757", MODE="0666", TAG+="uaccess"\
        ENV{ID_INPUT_JOYSTICK}="1"
        
        # GX100
        KERNEL=="hidraw*", ATTRS{idVendor}=="04b0"\
        MODE="0666", TAG+="uaccess"\
        ENV{ID_INPUT_JOYSTICK}="1"
      '';
      destination = "/etc/udev/rules.d/99-alixsim.rules";
    })
  ];
}
