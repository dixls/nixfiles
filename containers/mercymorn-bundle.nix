{config, pkgs, inputs, ...}: {
  imports = [
    ./omada
    ./gluetun
    # ./servarr
  ];
}
