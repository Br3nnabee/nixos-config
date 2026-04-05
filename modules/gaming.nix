{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      nur.repos.mio.proton-cachyos
      nur.repos.forkprince.proton-dw-bin
    ];
    extraPackages = with pkgs; [
      mangohud
      gamemode
    ];
  };
}
