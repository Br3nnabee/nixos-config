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
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        opacity = 0.5;

        padding = {
          x = 4;
          y = 4;
        };
        dynamic_padding = true;
        decorations = "full";
      };

      font = {
        normal.family = "Hack Nerd Font";
        size = 12.0;
      };

      scrolling.history = 10000;
    };
  };

  # State Version
  # DO NOT CHANGE
  home.stateVersion = "25.11";
}
