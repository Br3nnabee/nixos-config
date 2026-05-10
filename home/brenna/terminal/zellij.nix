# Zellij multiplexer with a custom zjstatus bar (pills layout).
# zjstatus is injected as pkgs.zjstatus via the overlay in
# modules/nixos/common/nixpkgs.nix - no extra import needed here.
{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      copy-command = "wl-copy";
      copy-on-select = true;
      mouse-mode = true;
      show_startup_tips = false;
      default_layout = "pills";
      pane_frames = false;
    };
  };

  # Layouts
  xdg.configFile."zellij/layouts/pills.kdl".text = ''
    layout {
      default_tab_template {
        pane size=1 borderless=true {
          plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
            // Mode and Session as standalone floating pills
            format_left   "{mode} #[bg=default,fg=#313244]#[bg=#313244,fg=#CDD6F4] {session} #[bg=default,fg=#313244]"
            format_center "{tabs}"
            format_right  "{command_date} {command_time}"
            format_space  "#[bg=default]"
            format_hide_on_overlength "true"
            format_precedence "lrc"

            hide_frame_for_single_pane "true"

            // Modes
            mode_normal "#[bg=default,fg=#89B4FA]#[bg=#89B4FA,fg=#1E1E2E,bold] NOR #[bg=default,fg=#89B4FA]"
            mode_pane   "#[bg=default,fg=#CBA6F7]#[bg=#CBA6F7,fg=#1E1E2E,bold] PANE #[bg=default,fg=#CBA6F7]"
            mode_tab    "#[bg=default,fg=#A6E3A1]#[bg=#A6E3A1,fg=#1E1E2E,bold] TAB #[bg=default,fg=#A6E3A1]"
            mode_locked "#[bg=default,fg=#F38BA8]#[bg=#F38BA8,fg=#1E1E2E,bold] LCK #[bg=default,fg=#F38BA8]"

            // Tabs
            tab_normal "#[bg=default,fg=#313244]#[bg=#313244,fg=#CDD6F4,bold] {index} #[bg=default,fg=#313244] "
            tab_active "#[bg=default,fg=#89B4FA]#[bg=#89B4FA,fg=#1E1E2E,bold] {index} #[bg=default,fg=#89B4FA] "

            // Date / Time
            command_date_command    "date +\"%d %b\""
            command_date_format     "#[bg=default,fg=#313244]#[bg=#313244,fg=#CDD6F4] {stdout} #[bg=default,fg=#313244]"
            command_date_interval   "15"
            command_date_rendermode "static"

            command_time_command    "date +\"%H:%M\""
            command_time_format     "#[bg=default,fg=#89B4FA]#[bg=#89B4FA,fg=#1E1E2E,bold] {stdout} #[bg=default,fg=#89B4FA]"
            command_time_interval   "15"
            command_time_rendermode "static"
          }
        }
        children
      }
      pane borderless=true
    }
  '';

  # Minimal borderless layout for when you want no chrome at all
  xdg.configFile."zellij/layouts/plain.kdl".text = ''
    layout {
      default_tab_template {
        children
      }
      pane borderless=true
    }
  '';
}
