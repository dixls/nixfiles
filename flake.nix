{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstablepkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # dotfiles = {
    #   url = "github:dixls/dotfiles/ab10684fae7de4f9279ba0c11ed240966d36bd80";
    #   flake = false;
    # };
    # nvim-config = {
    #   url = "github:dixls/nvim-config/heads/main";
    #   flake = false;
    # };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        snack-can = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix

	    home-manager.nixosModules.home-manager {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
	      home-manager.users.pixls = import ./pixls-home.nix;
	    }
          ];
        };
      };
    };
}
