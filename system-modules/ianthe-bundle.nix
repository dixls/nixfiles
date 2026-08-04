{pkgs, lib, config, ...}: {

  environment.systemPackages = with pkgs; [
    vllm
  ]

  networking = {
    firewall = {
      allowedTCPPorts = [
        8000
      ];
    };
  };

}
