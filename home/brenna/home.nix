{ config, pkgs, ... }:

{
  home.username = "brenna";
  home.homeDirectory = "/home/brenna";

  # Apps
  home.packages = with pkgs; [
    neovim
    alacritty
    bottom
    librewolf
    vlc
  ];

  # Basic Git setup
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Br3nnabee";
	email = "contact@br3nnabee.dev";
      };

      init.defaultBranch = "main";
      safe.directory = "/etc/nixos"; # Avoids perm issues
    };
  };

  # Shell configuration
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      # Rapid rebuild command
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#cobalt";
    };
  };

  home.stateVersion = "25.11";
}
