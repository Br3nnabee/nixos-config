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
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      cobalt = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # Pass inputs to modules
        modules = [
          ./hosts/cobalt/configuration.nix
          
          # Home Manager Module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.brenna = import ./home/brenna/home.nix;
          }
        ];
      };
    };
  };
}
