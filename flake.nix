{
  description = "pixls' nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstablepkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.4.0";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, utils, home-manager, ... }:
    let
      mkApp = utils.lib.mkApp;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in utils.lib.mkFlake {

      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];
      channelsConfig.allowUnfree = true;
      channelsConfig.allowBroken = false;

      hostsDefaults = {
        system = "x86_64-linux";
        extraArgs = { inherit utils inputs; };
        modules = ./hosts/common.host.nix;
      };

      hosts."snack-can".modules = [
        ./hosts/snack-can.host.nix
      ];
      
    };


    # {
    #   nixosConfigurations = {
    #     snack-can = lib.nixosSystem {
    #       inherit system;
    #       specialArgs = { inherit inputs; };
    #       modules = [
    #         ./configuration.nix

	  #   home-manager.nixosModules.home-manager {
	  #     home-manager.useGlobalPkgs = true;
	  #     home-manager.useUserPackages = true;
    #           home-manager.extraSpecialArgs = { inherit inputs; };
	  #     home-manager.users.pixls = import ./home/pixls.nix;
	  #   }
    #       ];
    #     };
    #   };
    # };
}
