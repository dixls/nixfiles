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

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    utils,
    home-manager,
    plasma-manager,
    nixos-cosmic,
    sops-nix,
    ...
  }:
    let
      system = "x86_64-linux";
      mkApp = utils.lib.mkApp;
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;

      commonModules = [
        ./hosts/common.host.nix
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.backupFileExtension = "backup3";
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
          home-manager.users.pixls = import ./home/pixls/home.nix;
        }
      ];
    in utils.lib.mkFlake {

      inherit self inputs;

      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          # extraSpecialArgs = { inherit inputs; };
          modules = [
            ./hosts/common.host.nix
          ];
        };

        snack-can = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ 
            ./hosts/snack-can.host.nix 
            commonModules
          ];
        };

        sweet = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = lib.lists.flatten [ 
            commonModules
            ./hosts/sweet/sweet.host.nix 
            sops-nix.nixosModules.sops
          ];
        };

        savory = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = lib.lists.flatten [ 
            commonModules
            ./hosts/savory/savory.host.nix 
            sops-nix.nixosModules.sops
          ];
        };

        space-port = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = lib.lists.flatten [ 
            commonModules
            ./hosts/space-port/space-port.host.nix
            sops-nix.nixosModules.sops

            # These are for Cosmic while it's still being worked on
            # {
            #   nix.settings = {
            #     substituters = [ "https://cosmic.cachix.org/" ];
            #     trusted-public-keys = [
            #       "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
            #     ];
            #   };
            # }
            # nixos-cosmic.nixosModules.default
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
