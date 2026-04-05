{ ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    keymap = {
      mgr.prepend_keymap = [
        # Custom keybinds
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
        # ── Swapped hjkl for neio ──
        # n → left / parent (was h)
        {
          on = [ "n" ];
          run = "leave";
          desc = "Go to parent directory";
        }
        # e → down (was j)
        {
          on = [ "e" ];
          run = "arrow -1";
          desc = "Move cursor down";
        }
        # i → up (was k)
        {
          on = [ "i" ];
          run = "arrow 1";
          desc = "Move cursor up";
        }
        # o → right / enter (was l)
        {
          on = [ "o" ];
          run = "enter";
          desc = "Enter hovered directory / open file";
        }

        # ── hjkl reassignment ──
        # h → find next (was n)
        {
          on = [ "h" ];
          run = "find --next";
          desc = "Jump to next search match";
        }
        # j → reveal hovered (was e)
        {
          on = [ "j" ];
          run = "reveal";
          desc = "Reveal / scroll to hovered file";
        }
        # k → inspect (was i)
        {
          on = [ "k" ];
          run = "inspect";
          desc = "Inspect hovered file details";
        }
        # l → open hovered (was o)
        {
          on = [ "l" ];
          run = "open";
          desc = "Open hovered file / enter directory";
        }
      ];
    };
  };
}
