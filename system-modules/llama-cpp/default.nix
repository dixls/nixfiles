{pkgs, lib, config, ...}: 
{
  services.llama-cpp = {
    enable = true;
    #package = pkgs.llama-cpp-vulkan;
    package = pkgs.llama-cpp-rocm;
    settings = {
      host = "0.0.0.0";
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [
        8080
      ];
    };
  };
}
