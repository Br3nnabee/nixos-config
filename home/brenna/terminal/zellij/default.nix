# Zellij multiplexer with a custom zjstatus bar (pills layout).
# zjstatus is injected as pkgs.zjstatus via the overlay in
# modules/nixos/common/nixpkgs.nix - no extra import needed here.
{
  pkgs,
  lib,
  ...
}:
{
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
  xdg.configFile."zellij/layouts/pills.kdl".text = lib.substituteAll {
    src = ./pills.kdl;
    ZJSTATUS = pkgs.zjstatus;
  };

  # Minimal borderless layout for when you want no chrome at all
  xdg.configFile."zellij/layouts/plain.kdl".source = ./plain.kdl;
}
