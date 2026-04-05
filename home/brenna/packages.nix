{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Shell & Navigation
    zellij
    broot

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

    # Gaming
    wine
    prismlauncher
    lutris
    mangohud
    gamemode

    # Assets
    nerd-fonts.hack
  ];

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
