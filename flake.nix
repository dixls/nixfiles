{
  description = "pixls' nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # nixos unstable
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.4.0";

    home-manager = {
      url = "github:nix-community/home-manager"; # unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-snapd = {
      url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pia = {
      url = "github:Fuwn/pia.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    authentik-nix = {
      url = "github:nix-community/authentik-nix";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    utils,
    home-manager,
    plasma-manager,
    sops-nix,
    nix-snapd,
    pia,
    kwin-effects-forceblur,
    authentik-nix,
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
          home-manager.backupFileExtension = "backup-1";
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

        nixpkgs.overlays = [ (final: prev: {
          inherit (prev.lixPackageSets.latest)
            nixpkgs-review
            nix-eval-jobs
            nix-fast-build
            colmena;
        }) ];
        nix.package = pkgs.lixPackageSets.stable.lix;

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

        mercymorn = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = lib.lists.flatten [ 
            commonModules
            ./hosts/mercymorn/mercymorn.host.nix 
            sops-nix.nixosModules.sops
          ];
        };

        harrowhark = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = lib.lists.flatten [ 
            commonModules
            ./hosts/harrowhark/harrowhark.host.nix 
            sops-nix.nixosModules.sops
            pia.nixosModules."x86_64-linux".default
          ];
        };

        gideon = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = lib.lists.flatten [ 
            commonModules
            ./hosts/gideon/gideon.host.nix 
            sops-nix.nixosModules.sops
          ];
        };

        pve-basic = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = lib.lists.flatten [ 
            commonModules
            ./hosts/pve-basic/pve-basic.host.nix 
            sops-nix.nixosModules.sops
          ];
        };

        space-port = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = lib.lists.flatten [ 
            commonModules
            ./hosts/space-port/space-port.host.nix
            sops-nix.nixosModules.sops
            ./gui/plasma
            # ./gui/gnome
            # lix-module.nixosModules.default
            nix-snapd.nixosModules.default
            {
              services.snap.enable = true;
            }
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
