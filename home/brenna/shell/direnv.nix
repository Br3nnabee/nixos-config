# direnv automatically loads/unloads per-project Nix devShells.
# nix-direnv caches the shell derivation so it doesn't re-evaluate on
# every cd, which is critical for large flakes.
_: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;

    config.global.hide_env_diff = true; # less noisy output on env change
  };
}
