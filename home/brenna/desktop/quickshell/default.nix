{
  config,
  lib,
  ...
}: let
  inherit (config.lib.stylix) colors;
in {
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile."quickshell/launcher.qml".text = lib.substituteAll {
    src = ./launcher.qml;
    inherit (colors) base00;
    inherit (colors) base01;
    inherit (colors) base02;
    inherit (colors) base03;
    inherit (colors) base04;
    inherit (colors) base05;
    inherit (colors) base0D;
    monoFont = config.stylix.fonts.monospace.name;
    sansFont = config.stylix.fonts.sansSerif.name;
  };
}
