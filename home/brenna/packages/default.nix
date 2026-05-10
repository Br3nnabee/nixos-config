# Splits the package list into logical groups so additions/removals
# produce clean, single-concern diffs.
{...}: {
  imports = [
    ./cli.nix
    ./dev.nix
    ./gui.nix
    ./librewolf.nix
    ./gaming.nix
    ./tf2
    ./kovaaks
    ./security.nix
  ];
}
