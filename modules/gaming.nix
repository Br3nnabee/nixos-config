{ pkgs, ... }:

{
  # Steam Config
  programs.steam = {
    enable = true;
    # Allows for multiplayer + remoteplay hosting
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    # Gamescope for better compatability
    gamescopeSession.enable = true;
    # Alternative proton forks
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      nur.repos.mio.proton-cachyos
      nur.repos.forkprince.proton-dw-bin
    ];
  };

  programs.alvr = {
    enable = true;
    openFirewall = true;
  };
}
