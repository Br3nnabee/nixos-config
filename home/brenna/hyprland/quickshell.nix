{ ... }:

{
  programs.quickshell = {
    enable = true;

    systemd.enable = true;

  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "quickshell" # runs the active/default config
  ];
}
