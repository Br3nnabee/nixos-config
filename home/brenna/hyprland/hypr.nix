{ ... }:

{
  imports = [
    ./binds.nix
    ./quickshell.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "DP-3,1920x1080@165,1920x0,1";

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };

      decoration = {
        rounding = 10;
        shadow = {
          enabled = true;
        };
        blur = {
          enabled = true;
          size = 3;
        };
      };

      windowrule = [
        # Suppress maximize requests from all apps
        "suppress_event maximize, match:class .*"

        # No focus on empty/ghost XWayland windows
        "no_focus on, match:class ^$, match:title ^$, match:xwayland true"

        # Small centered floating terminal
        "float on, size 640 400, center on, match:class ^floatingterm$"

        # Centers dialogs etc.
        "float 1, match:modal 1"
        "match:float 1"

      ];
    };
  };
}
