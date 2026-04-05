{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      copy-command = "wl-copy";
      show_startup_tips = false;
      default_layout = "pills";
      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };
    };
  };

  xdg.configFile."zellij/layouts/pills.kdl".text = ''
    layout {
      default_tab_template {
        children
        pane size=1 borderless=true {
          plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
            // Mode flows into Session. Tabs are standalone pills.
            format_left   "{mode}#[bg=#313244,fg=#CDD6F4] {session} #[bg=default,fg=#313244]"
            format_center "{tabs}"
            format_right "{command_date}{command_time}"
            format_space  "#[bg=default]"
            format_hide_on_overlength "true"
            format_precedence "lrc"

            hide_frame_for_single_pane  "true"

            // MODES WITH HARDCODED KEYBINDS
            // NORMAL: No binds shown.
            mode_normal   "#[bg=default,fg=#89B4FA]#[bg=#89B4FA,fg=#1E1E2E,bold] NOR #[bg=#313244,fg=#89B4FA]"
            
            // PANE (Ctrl+p)
            mode_pane     "#[bg=default,fg=#CBA6F7]#[bg=#CBA6F7,fg=#1E1E2E,bold] PANE #[bg=#313244,fg=#CBA6F7]#[bg=#313244,fg=#CDD6F4] p:New  x:Close  f:Float #[bg=#313244,fg=#6C7086]"
            
            // TAB (Ctrl+t)
            mode_tab      "#[bg=default,fg=#A6E3A1]#[bg=#A6E3A1,fg=#1E1E2E,bold] TAB #[bg=#313244,fg=#A6E3A1]#[bg=#313244,fg=#CDD6F4] n:New  x:Close  r:Rename #[bg=#313244,fg=#6C7086]"
            
            // LOCKED (Ctrl+g)
            mode_locked   "#[bg=default,fg=#F38BA8]#[bg=#F38BA8,fg=#1E1E2E,bold] LCK #[bg=#313244,fg=#F38BA8]"

            // TABS
            tab_normal    "#[bg=default,fg=#313244]#[bg=#313244,fg=#CDD6F4,bold] {index} #[bg=default,fg=#313244] "
            tab_active    "#[bg=default,fg=#89B4FA]#[bg=#89B4FA,fg=#1E1E2E,bold] {index} #[bg=default,fg=#89B4FA] "

            // DATETIME
            command_date_command "date +\"%d %b\""
            command_date_format  "#[bg=default,fg=#313244]#[bg=#313244,fg=#CDD6F4] {stdout} "
            command_date_interval "15"
            command_date_rendermode "static"

            command_time_command "date +\"%H:%M\""
            command_time_format  "#[bg=#313244,fg=#89B4FA]#[bg=#89B4FA,fg=#1E1E2E,bold] {stdout} #[bg=default,fg=#89B4FA]"
            command_time_interval "15"
            command_time_rendermode "static"
          }
        }
      }
    }'';

  xdg.configFile."zellij/layouts/plain.kdl".text = ''
    layout {
      default_tab_template {
        children
      }
      pane borderless=true
    }'';

}
