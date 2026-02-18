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
    GTK_USE_PORTAL = "1";
  };

  # Basic Git setup
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Br3nnabee";
	email = "contact@br3nnabee.dev";
      };

      init.defaultBranch = "main";
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
