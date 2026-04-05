{ ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      default_layout = "powerline";
    };
  };

  xdg.configFile."zellij/layouts/poweline.kdl".text = ''
    layout {
      default_tab_template {
        children
        pane size=1 borderless=true {
          plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {  // Reference the Nix-installed wasm
            format_left   "{mode}#[fg=#89B4FA,bg=#1E1E2E,bold] {session}#[fg=#1E1E2E,bg=#89B4FA]"  // Powerline arrow 
            format_center "{tabs}"
            format_right  "#[fg=#89B4FA,bg=#1E1E2E]#[fg=#1E1E2E,bg=#89B4FA] {command_git_branch} #[fg=#F38BA8,bg=#89B4FA]#[fg=#1E1E2E,bg=#F38BA8] {datetime}"
            format_space  "#[bg=#1E1E2E] "  // Background for segments

            border_enabled  "true"
            border_char     "─"
            border_format   "#[fg=#6C7086]{char}"
            border_position "top"

            hide_frame_for_single_pane "true"

            mode_normal     "#[fg=#1E1E2E,bg=#89B4FA] NORMAL "
            mode_locked     "#[fg=#1E1E2E,bg=#F38BA8] LOCKED "
            // Add more modes as needed, e.g., mode_tmux "#[fg=#1E1E2E,bg=#FFC387] TMUX "

            tab_normal      "#[fg=#6C7086,bg=#1E1E2E] {name} #[fg=#1E1E2E,bg=#6C7086] "
            tab_active      "#[fg=#CDD6F4,bg=#1E1E2E,bold,italic] {name} #[fg=#1E1E2E,bg=#CDD6F4] "

            command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
            command_git_branch_format      "#[fg=#89B4FA] ({stdout}) "
            command_git_branch_interval    "10"
            command_git_branch_rendermode  "static"

            datetime        "#[fg=#CDD6F4] {format} "
            datetime_format "%A, %d %b %Y %H:%M"
            datetime_timezone "Europe/Paris"  // Matches your timezone
          }
        }
      }
    }'';
}
