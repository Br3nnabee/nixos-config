# Visual and behavioural Hyprland settings: monitor layout, gaps, borders,
# input sensitivity, decorations, and window rules.
# Keybinds live in binds.nix; exec-once lives in autostart.nix.
_: {
  wayland.windowManager.hyprland.settings = {
    # Monitor
    # Format: name, resolution@hz, position, scale
    monitor = [
      "DP-3,1920x1080@165,1920x0,1"
      "DP-2,1920x1080@165,1920x0,1"
      "DP-1,1920x1080@165,1920x0,1"
    ];

    # Layout
    general = {
      gaps_in = 5;
      gaps_out = 20;
      border_size = 2;
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
      allow_tearing = true;
    };

    # Input
    input = {
      sensitivity = -0.5;
      accel_profile = "flat"; # disable mouse acceleration for consistency
    };

    # Decorations
    decoration = {
      rounding = 10;
      shadow.enabled = true;
      blur = {
        enabled = true;
        size = 3;
      };
    };

    # Window rules
    windowrule = [
      # Suppress maximize requests from all apps
      "suppress_event maximize, match:class .*"

      # Ignore ghost/empty XWayland windows (avoids focus steal)
      "no_focus on, match:class ^$, match:title ^$, match:xwayland true"

      # Floating scratchpad terminal spawned by $mainMod+RETURN
      "float on, size 720 400, center on, match:class ^floatingterm$"

      # Auto-float modal dialogs
      "float 1, match:modal 1"
      "match:float 1"

      # Allows tearing for fullscreen progams.
      "immediate on, match:fullscreen 1"
    ];
  };
}
