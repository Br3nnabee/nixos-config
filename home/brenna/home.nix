{ config, pkgs, ... }:

{
  home.username = "brenna";
  home.homeDirectory = "/home/brenna";

  imports = [
    ./packages.nix
    ./nvim.nix
    ./yazi.nix
    ./hyprland/hypr.nix
  ];

  home.sessionVariables = {
    # Some programs don't play nice w/o it.
    GTK_USE_PORTAL = "1";
  };

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

    settings = {
      user = {
        name = "Br3nnabee";
	email = "contact@br3nnabee.dev";
      };

      signing = {
        key = "1CAFECB4EB3B3238";
	signByDefault = true;
      };

      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };


  # Shell configuration
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      # Rapid rebuild command
      rebuild = "sudo nixos-rebuild switch --flake $HOME/.nixos-config#cobalt";
    };
  };

  home.stateVersion = "25.11";
}
