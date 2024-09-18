{
  description = "pixls' nix config";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11"; # nixos 23.11
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; # nixos 24.05
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # nixos unstable
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.4.0";

    home-manager = {
      url = "github:nix-community/home-manager"; # unstable
      # url = "github:nix-community/home-manager/release-24.05";
      # url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # probably getting rid of these
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs@{ self, nixpkgs, utils, home-manager, darwin, hyprland, plasma-manager, ... }:
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

      supportedSystems = [ "x86_64-linux" ];
      channelsConfig.allowUnfree = true;
      channelsConfig.allowBroken = false;

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
              home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
            }
            ./configuration.nix
          ];
        };

      darwinConfigurations.space-cadet = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/darwin/space-cadet.host.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.users.pixls = import ./home/pixls/home.nix;
          }
        ];
      };
    };
  };
}
