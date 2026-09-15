{ config, pkgs, lib, ... }:

let
  gx100Driver = rec {
    owner = "JacKeTUs";
    repo  = "hid-gx100-shifter";
    rev   = "main"; # ⚠️ Replace with a specific commit/tag for reproducibility
    hash  = "sha256-PLACEHOLDER"; # Nix will give you the exact hash on first build
  };

  hidGx100Driver = pkgs.linuxPackages.buildModule rec {
    moduleVersion = "1.0";
    src = pkgs.fetchFromGitHub {
      inherit (gx100Driver) owner repo rev hash;
    };
  };
in {
  # 1️⃣ Kernel module build & load
  boot.extraModulePackages = [ hidGx100Driver ];
  boot.kernelModules       = [ "hid-gx100-shifter" ];

  # 2️⃣ Udev rules (correct option)
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c294", MODE="0660", GROUP="plugdev"
  '';

  # Ensure group exists
  users.groups.plugdev = {};
}
