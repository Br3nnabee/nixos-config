# Command-line packages that don't have meaningful HM program options
# (those live in shell/tools.nix instead).
{pkgs, ...}: {
  home.packages = with pkgs; [
    # Shell & navigation
    xdg-user-dirs # sets up ~/Desktop, ~/Downloads, etc.

    # Nix utilities
    nh # friendly nix rebuild / diff UI
    comma # run any nixpkgs binary with `, foo` without installing
    nix-index # file-to-package lookup
    nvd # nix version diff — shows what changed between builds
    alejandra # opinionated Nix formatter
    appimage-run

    # Modern Unix replacements
    eza # ls replacement with icons/git
    fd # find replacement
    ripgrep # grep replacement
    procs # ps replacement
    ouch # universal archive tool (zip/tar/zst/…)
    trash-cli # safe delete → ~/.local/share/Trash
    tldr # concise man pages
    doggo # dig replacement
    sd # sed replacement
    unrar

    # System & network monitoring
    bottom # htop replacement (btm)
    duf # df replacement
    dust # du replacement
    gping # ping with graph
    pavucontrol # PipeWire/PulseAudio GUI mixer
    tokei # code line counter
    hyperfine # command benchmarking

    libarchive
    e2fsprogs
    pkg-config
  ];
}
