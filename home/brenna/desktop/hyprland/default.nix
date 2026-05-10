{
  config,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      source = ${./settings.conf}
      source = ${./autostart.conf}
      source = ${lib.substituteAll {
        src = ./binds.conf;
        HOME = config.home.homeDirectory;
      }}
    '';
  };
}
