# User-space gaming packages and Lutris configuration.
# System-level Steam / ALVR live in modules/nixos/hardware/gaming.nix.
{pkgs, ...}: {
  home.packages = with pkgs; [
    # Windows compatibility
    wine # Wine HQ stable
    winetricks # Wine prefix setup helper
    protontricks # Proton prefix setup helper
    umu-launcher # Universal Proton launcher

    # Launchers & mod managers
    prismlauncher # Minecraft (multi-instance, modded)
    flightgear # open-source flight simulator
    ckan # KSP mods

    # Performance overlays
    mangohud # in-game GPU/CPU/FPS overlay
    gamemode # temporary performance profile daemon
  ];

  # Lutris
  # NUR packages (proton-cachyos, proton-dw-bin) are available via the
  # nur overlay declared in modules/nixos/common/nixpkgs.nix.
  programs.lutris = {
    enable = true;

    protonPackages = with pkgs; [
      proton-ge-bin

      # NUR packages need this tiny override so home-manager's Lutris module is happy
      (nur.repos.mio.proton-cachyos // {steamcompattool = nur.repos.mio.proton-cachyos;})
      (nur.repos.forkprince.proton-dw-bin // {steamcompattool = nur.repos.forkprince.proton-dw-bin;})
    ];

    winePackages = [pkgs.wine-wayland];

    extraPackages = with pkgs; [
      mangohud
      gamescope
      gamemode
      umu-launcher
    ];
  };
}
