# Composes the three Hyprland layers: visual settings, keybinds, autostart.
# Splitting them makes diffs cleaner — a keybind change doesn't touch
# the monitor config file, and vice versa.
{...}: {
  imports = [
    ./settings.nix
    ./binds.nix
    ./autostart.nix
  ];

  wayland.windowManager.hyprland.enable = true;
}
