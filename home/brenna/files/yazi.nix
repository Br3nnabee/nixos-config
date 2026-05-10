# Yazi file manager. Keybinds are remapped for Colemak-DH layout:
#   neio  → left/down/up/right
_: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    settings.preview = {
      image_protocol = "kitty";
      image_quality = 90;
    };

    keymap.mgr.prepend_keymap = [
      {
        on = [ "<A-d>" ];
        run = "shell -- ripdrag -A %s &";
        desc = "Drag and drop selected files";
      }
      {
        on = [ "<Del>" ];
        run = "shell -- trash-put %s";
        desc = "Move selected files to trash";
      }

      # Colemak directional remaps
      {
        on = [ "n" ];
        run = "leave";
        desc = "Go to parent directory";
      }
      {
        on = [ "i" ];
        run = "arrow 1";
        desc = "Move cursor down";
      }
      {
        on = [ "e" ];
        run = "arrow -1";
        desc = "Move cursor up";
      }
      {
        on = [ "o" ];
        run = "enter";
        desc = "Enter directory / open file";
      }

      # hjkl reassignment
      {
        on = [ "h" ];
        run = "find --next";
        desc = "Jump to next search match";
      }
      {
        on = [ "j" ];
        run = "reveal";
        desc = "Reveal hovered file";
      }
      {
        on = [ "k" ];
        run = "inspect";
        desc = "Inspect hovered file details";
      }
      {
        on = [ "l" ];
        run = "open";
        desc = "Open hovered file";
      }
    ];
  };
}
