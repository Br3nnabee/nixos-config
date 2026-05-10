{pkgs, ...}: {
  # Virtual filesystem (enables Trash, MTP, SMB in file managers)
  services.gvfs.enable = true;

  # Flatpak for one-off GUI apps not packaged in nixpkgs
  services.flatpak.enable = true;

  # Power management service (needed by wireplumber and bars)
  services.upower.enable = true;

  # Performance: Auto-prioritize processes
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };

  # Performance: Distribute IRQs across cores
  services.irqbalance.enable = true;

  # Hardware: RGB control
  services.hardware.openrgb.enable = true;

  # Hardware: Mouse configuration (Piper backend)
  services.ratbagd.enable = true;
}
