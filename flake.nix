{
  description = "Brenna's multi-device Nix config (desktop & laptop)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kitty-astro-nvim = {
      url = "github:br3nnabee/kittyAstroNvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:nix-community/stylix";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.git-hooks-nix.flakeModule
      ];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        # Unified formatting via treefmt
        treefmt = {
          projectRootFile = "flake.nix";
          programs = {
            alejandra.enable = true;
            deadnix.enable = true;
            statix.enable = true;
            prettier.enable = true;
            taplo.enable = true;
          };
        };

        # Pre-commit hooks
        pre-commit = {
          check.enable = true;
          settings.hooks = {
            treefmt.enable = true;
            nil.enable = true;
          };
        };

        devShells.default = pkgs.mkShell {
          shellHook = config.pre-commit.installationScript;
          packages = with pkgs; [
            nh
            sops
            age
          ];
        };
      };

      flake = let
        lib = import ./lib {
          inherit inputs;
          root = self;
        };
      in {
        nixosConfigurations = {
          # Cobalt
          cobalt = lib.mkHost {
            hostname = "cobalt";
            user = "brenna";
            system = "x86_64-linux";
            extraModules = [
              inputs.nixos-hardware.nixosModules.common-cpu-intel
              inputs.stylix.nixosModules.stylix
              ./modules/nixos/hardware/nvidia.nix
              ./modules/nixos/hardware/gaming.nix
              ./modules/nixos/hardware/wooting.nix
              ./modules/nixos/desktop/hyprland.nix
              ./modules/nixos/virt
              ./modules/nixos/memory
              inputs.kitty-astro-nvim.nixosModules.astroNvim
            ];
          };
        };
      };
    };
}
