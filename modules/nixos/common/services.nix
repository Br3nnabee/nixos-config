# Small system-level services that are host-agnostic.
_: {
  # Virtual filesystem (enables Trash, MTP, SMB in file managers)
  services.gvfs.enable = true;

  # Flatpak for one-off GUI apps not packaged in nixpkgs
  services.flatpak.enable = true;

  # Power management service (needed by wireplumber and bars)
  services.upower.enable = true;
}
