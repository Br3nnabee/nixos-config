{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Shell & Navigation
    zellij
    broot
    xdg-user-dirs

    # Nix Utils
    nh
    comma
    nvd
    alejandra

    # Modern Unix Replacements
    fd
    ripgrep
    procs
    ouch
    trash-cli
    tldr
    doggo
    sd
    unrar

    # System & Network Monitoring
    bottom
    duf
    dust
    gping
    pavucontrol
    tokei
    hyperfine

    # Dev & Git
    mise
    gh
    gh-dash
    delta
    patchelf
    pinentry-curses

    # GUI / Productivity
    librewolf
    keepassxc
    vesktop
    foliate
    vlc
    zenity
    quickshell
    ripdrag
    aria2
    qbittorrent
    blueman
    kicad
    scrcpy
    grimblast

    # Gaming
    wine
    prismlauncher
    mangohud
    gamemode
    winetricks
    protontricks
    umu-launcher
    flightgear

    # Pentesting
    wpscan

    # Assets
    nerd-fonts.hack
  ];

  programs.lutris = {
    enable = true;
    protonPackages = with pkgs; [
      (pkgs.proton-ge-bin.overrideAttrs (old: {
        steamcompattool = pkgs.proton-ge-bin; # hack — probably won't actually work
      }))
      (nur.repos.mio.proton-cachyos.overrideAttrs (old: {
        steamcompattool = nur.repos.forkprince.proton-cachyos-v4-bin;
      }))
      (nur.repos.forkprince.proton-dw-bin.overrideAttrs (old: {
        steamcompattool = nur.repos.forkprince.proton-dw-bin;
      }))
    ];
    winePackages = [ pkgs.wine-wayland ];
    extraPackages = with pkgs; [
      mangohud
      gamescope
      gamemode
      umu-launcher
    ];
  };

  programs.broot = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };
}
