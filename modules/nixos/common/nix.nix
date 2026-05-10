_: {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    use-xdg-base-directories = true;

    # Binary caches for fenix, NUR, and zjstatus
    # Adding these means builds are served from cache instead of local compilation.
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://fenix.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "fenix.cachix.org-1:erQjK2EYQKob7TeDGQ4GdmF0ynUKe0CaLghkVRkbMNA="
    ];

    # Hard-link identical files in the store to save disk space
    auto-optimise-store = true;

    # Use remote substituters even when building on behalf of another machine
    builders-use-substitutes = true;

    # Restrict nix daemon access to root and the wheel group
    allowed-users = ["root" "@wheel"];
    trusted-users = ["root" "@wheel"];
  };

  # Weekly explicit optimisation to catch anything missed
  nix.optimise.automatic = true;

  # Garbage collect automatically once a week; keep last 7 days of generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
