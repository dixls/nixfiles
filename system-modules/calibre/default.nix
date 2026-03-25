{pkgs, lib, config, ...}: {
  services.calibre-web = {
    enable = true;
    user = config.services.immich.user;
    listen.ip = "0.0.0.0";
    openFirewall = true;
    options = {
      calibreLibrary = "/media/media/calibre-library";
      enableBookUploading = true;
      enableBookConversion = true;
      enableKepubify = true;
    };
  };
}
