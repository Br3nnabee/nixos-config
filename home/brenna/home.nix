{ pkgs, ... }:

{
  home.username = "brenna";
  home.homeDirectory = "/home/brenna";

  imports = [
    ./packages.nix
    ./nvim.nix
    ./yazi.nix
    ./zellij.nix
    ./hyprland/hypr.nix
  ];

  # Environment variables
  home.sessionVariables = {
    FLAKE = "/home/brenna/.nixos-config";
    NH_FLAKE = "/home/brenna/.nixos-config";
    UEBERZUGPP_BACKEND = "wayland";
  };

  # GPG stuff
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
    enableSshSupport = true;
    enableZshIntegration = true;
    sshKeys = [ "F0864B8705DFEDB725B406640AD05207591774F7" ];
    defaultCacheTtl = 3600;
    maxCacheTtl = 86400;
    defaultCacheTtlSsh = 3600;
    maxCacheTtlSsh = 86400;
  };
  programs.gpg.settings = {
    use-agent = true;
    no-comments = true;
    with-fingerprint = true;
  };

  # Git stuff
  programs.git = {
    enable = true;

    signing = {
      key = "1CAFECB4EB3B3238";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Br3nnabee";
        email = "contact@br3nnabee.dev";
      };

      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  # Qt6
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  # Shell configuration
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };
  };

  # Makes shell.nix easier
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;

    config = {
      global.hide_env_diff = true;
    };
  };

  # Terminal configuration
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.5";
      font_family = "Hack Nerd Font";
      font_size = 12;
      scrollback_lines = 10000;
      confirm_os_window_close = 0;
      window_padding_width = "2 4";
      linux_display_server = "wayland";

      background_tint = "0.0";
      background_tint_gaps = "0.0";

      # Better color rendering
      term = "xterm-256color";
      undercurl_style = "thin-sparse";

      # Smoother rendering
      sync_to_monitor = true;
      repaint_delay = 10;
      input_delay = 3;
    };
  };

  # State Version
  # DO NOT CHANGE
  home.stateVersion = "25.11";
}
