# Quickshell is started via Hyprland's exec-once in autostart.nix.
_: {
  programs.quickshell = {
    enable = true;
    systemd.enable = true; # integrate with systemd user session
  };
}
