{
  description = "pixls' nix config";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.4.0";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = inputs@{ self, nixpkgs, utils, home-manager, hyprland, ... }:
    let
      system = "x86_64-linux";
      mkApp = utils.lib.mkApp;
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in utils.lib.mkFlake {

      inherit self inputs;

      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./hosts/common.host.nix
            ./configuration.nix
          ];
        };

        snack-can = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ 
            ./hosts/common.host.nix
            ./hosts/snack-can.host.nix 
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit hyprland;
              };
              home-manager.users.pixls = import ./home/pixls/home.nix;
            }
            ./configuration.nix
          ];
        };

      supportedSystems = [ "x86_64-linux" ];
      channelsConfig.allowUnfree = true;
      channelsConfig.allowBroken = false;

    };

    # homeConfigurations.pixls = home-manager.lib.homeManagerConfiguration {
    #   pkgs = nixpkgs.legacyPackages.${system};
    #   modules = [
    #     ./home/pixls/home.nix
    #   ];
    # };
  };
}
