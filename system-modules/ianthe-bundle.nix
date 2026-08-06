{pkgs, lib, config, ...}: {

  imports = [
    ./llama-cpp
  ];

  environment.systemPackages = with pkgs; [
    #vllm
    #llama-cpp-vulkan
  ];

  networking = {
    firewall = {
      allowedTCPPorts = [
        #8000
        8080
        #config.services.llama-cpp.settings.port
      ];
    };
  };

}
