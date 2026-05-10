# All Hyprland keybindings. Directional keys use Colemak home-row:
#   n = left, e = down, i = up, o = right
_: {
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$terminal" = "kitty";
    "$fileManager" = "kitty -e yazi";

    bind = [
      # General
      "$mainMod, R,                exec, $terminal"
      "$mainMod, RETURN,           exec, $terminal --class floatingterm"
      "$mainMod, Q,                killactive"
      "ALT, F4,                    killactive"
      "$mainMod, F11,              fullscreen"
      "$mainMod, F,                exec, librewolf"
      "$mainMod SHIFT, F,          exec, librewolf --private-window"
      "$mainMod, W,                exec, $fileManager"
      "$mainMod, S,                exec, hyprctl --batch 'dispatch togglefloating; dispatch centerwindow 1'"
      "$mainMod, P,                pseudo"
      "$mainMod, J,                togglesplit"
      "$mainMod, D,                pin"
      "$mainMod, semicolon,        togglespecialworkspace"
      "$mainMod SHIFT, semicolon,  movetoworkspace, special"
      ", PRINT,                    exec, grimblast copysave area"
      "$mainMod, PRINT,            exec, grimblast copysave screen"

      # Split control
      "$mainMod, V,           layoutmsg, swapsplit"
      "$mainMod CTRL, N,      layoutmsg, preselect l"
      "$mainMod CTRL, O,      layoutmsg, preselect r"
      "$mainMod CTRL, E,      layoutmsg, preselect d"
      "$mainMod CTRL, I,      layoutmsg, preselect u"

      # Window groups
      "$mainMod, G,           togglegroup"
      "$mainMod ALT, G,       lockactivegroup"
      "$mainMod, Tab,         changegroupactive, f"
      "$mainMod SHIFT, Tab,   changegroupactive, b"

      # Window movement (arrows + Colemak)
      "$mainMod CTRL, left,   movewindow, l"
      "$mainMod CTRL, N,      movewindow, l"
      "$mainMod CTRL, right,  movewindow, r"
      "$mainMod CTRL, O,      movewindow, r"
      "$mainMod CTRL, up,     movewindow, u"
      "$mainMod CTRL, I,      movewindow, u"
      "$mainMod CTRL, down,   movewindow, d"
      "$mainMod CTRL, E,      movewindow, d"

      # Focus (arrows + Colemak)
      "$mainMod, left,        movefocus, l"
      "$mainMod, N,           movefocus, l"
      "$mainMod, right,       movefocus, r"
      "$mainMod, O,           movefocus, r"
      "$mainMod, up,          movefocus, u"
      "$mainMod, I,           movefocus, u"
      "$mainMod, down,        movefocus, d"
      "$mainMod, E,           movefocus, d"
      "ALT, Tab,              cyclenext"
      "$mainMod, Tab,         swapnext"

      # Workspaces
      "$mainMod, 1,  workspace, 1"
      "$mainMod, 2,  workspace, 2"
      "$mainMod, 3,  workspace, 3"
      "$mainMod, 4,  workspace, 4"
      "$mainMod, 5,  workspace, 5"
      "$mainMod, 6,  workspace, 6"
      "$mainMod, 7,  workspace, 7"
      "$mainMod, 8,  workspace, 8"
      "$mainMod, 9,  workspace, 9"
      "$mainMod, 0,  workspace, 10"

      "$mainMod SHIFT, 1,  movetoworkspace, 1"
      "$mainMod SHIFT, 2,  movetoworkspace, 2"
      "$mainMod SHIFT, 3,  movetoworkspace, 3"
      "$mainMod SHIFT, 4,  movetoworkspace, 4"
      "$mainMod SHIFT, 5,  movetoworkspace, 5"
      "$mainMod SHIFT, 6,  movetoworkspace, 6"
      "$mainMod SHIFT, 7,  movetoworkspace, 7"
      "$mainMod SHIFT, 8,  movetoworkspace, 8"
      "$mainMod SHIFT, 9,  movetoworkspace, 9"
      "$mainMod SHIFT, 0,  movetoworkspace, 10"

      # Scroll through workspaces
      "$mainMod, mouse_down,  workspace, e+1"
      "$mainMod, mouse_up,    workspace, e-1"
    ];

    bindm = [
      "$mainMod, mouse:272,  movewindow"
      "$mainMod, mouse:273,  resizewindow"
    ];

    binde = [
      "$mainMod SHIFT, N,  resizeactive, -20 0"
      "$mainMod SHIFT, O,  resizeactive,  20 0"
      "$mainMod SHIFT, I,  resizeactive,  0 -20"
      "$mainMod SHIFT, E,  resizeactive,  0  20"
    ];

    bindl = [
      ", XF86AudioRaiseVolume,    exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume,    exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute,           exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86MonBrightnessUp,     exec, brightnessctl set 5%+"
      ", XF86MonBrightnessDown,   exec, brightnessctl set 5%-"
    ];
  };
}
