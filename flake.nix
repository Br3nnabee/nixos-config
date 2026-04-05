{
  description = "Cobalt System Flake Configuration";

  inputs = {
    # Official NixOS package source.
    # WARNING: Currently using unstable.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager (manages user dotfiles).
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repo.
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kitty-astro-nvim = {
      url = "github:br3nnabee/kittyAstroNvim/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      kitty-astro-nvim,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        cobalt = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            nixpkgs-unstable = inputs.nixpkgs;
          };
          modules = [
            ./hosts/cobalt/configuration.nix

            # Home Manager Module
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.brenna = import ./home/brenna/home.nix;
            }
            # Kitty Nvim
            kitty-astro-nvim.nixosModules.astroNvim
          ];
        };
      };
    };
}
