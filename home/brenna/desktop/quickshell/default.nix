{
  config,
  lib,
  ...
}:
let
  inherit (config.lib.stylix) colors;
in
{
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile."quickshell/launcher.qml".text =
    lib.substituteAll {
      src = ./launcher.qml;
      base00 = colors.base00;
      base01 = colors.base01;
      base02 = colors.base02;
      base03 = colors.base03;
      base04 = colors.base04;
      base05 = colors.base05;
      base0D = colors.base0D;
      monoFont = config.stylix.fonts.monospace.name;
      sansFont = config.stylix.fonts.sansSerif.name;
    };
}
