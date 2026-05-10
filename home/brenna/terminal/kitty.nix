_: {
  programs.kitty = {
    enable = true;

    settings = {
      # Appearance
      window_padding_width = "2 4";

      # Backend
      linux_display_server = "wayland";

      # Behaviour
      copy_on_select = "yes";
      scrollback_lines = 10000;
      scroll_on_output = "yes";
      scroll_on_keystroke = "yes";
      confirm_os_window_close = 0;
      mouse_hide_wait = "3.0";
      strip_trailing_spaces = "smart";
      shell_integration = "enabled";

      # Rendering
      term = "xterm-256color";
      undercurl_style = "thin-sparse";
      sync_to_monitor = true;
      repaint_delay = 10;
      input_delay = 3;
    };
  };
}
