# Provides mkHost — a thin factory that wires together the common module
# stack with per-host extras. Both `root` (=self) and `inputs` are
# injected so path literals here resolve against the flake root rather
# than the lib directory.
{
  inputs,
  root,
}: let
  inherit (inputs) nixpkgs home-manager sops-nix;
in {
  mkHost = {
    hostname,
    user,
    system ? "x86_64-linux",
    extraModules ? [],
  }:
    nixpkgs.lib.nixosSystem {
      inherit system;

      # Everything a module might need that isn't a package.
      # `user` lets any module parametrize on the primary username
      specialArgs = {inherit inputs user;};

      modules =
        [
          # Shared system config
          "${root}/modules/nixos/common"
          "${root}/hosts/${hostname}/default.nix"

          # Secret management
          sops-nix.nixosModules.sops

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            home-manager.users.${user} = import "${root}/home/${user}/home.nix";
            home-manager.extraSpecialArgs = {inherit inputs user;};
          }
        ]
        ++ extraModules;
    };
}
