{ config, pkgs, ... }: {
  home.username = "brenna";
  home.homeDirectory = "/home/brenna";
  home.stateVersion = "25.11"; 

  home.packages = with pkgs; [
    tree
    # Add other user apps here
  ];

  programs.bash.enable = true;
  programs.bash.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#cobalt";
  };
}
