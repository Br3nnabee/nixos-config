# Programs launched once at Hyprland startup.
# Keep this list minimal — prefer systemd user services where possible
# (quickshell already uses systemd.enable = true in quickshell.nix).
_: {
  wayland.windowManager.hyprland.settings.exec-once = [
    "hyprpolkitagent"
    "quickshell" # shell / bar compositor
  ];
}
