{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty
    bottom
    librewolf
    vlc
    keepassxc
    zenity
    ripdrag
    trash-cli
    zip
    unzip

    nerd-fonts.hack
  ];
}
