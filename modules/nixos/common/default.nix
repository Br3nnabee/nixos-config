{...}: {
  imports = [
    ./boot.nix
    ./nix.nix
    ./nixpkgs.nix
    ./networking.nix
    ./locale.nix
    ./audio.nix
    ./portals.nix
    ./users.nix
    ./services.nix
    ./security.nix
    ./secureboot.nix
    ./fonts.nix
    ./stylix.nix
  ];
}
