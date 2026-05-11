# System-wide theming configuration using Stylix.
# This unifies colors, fonts, and wallpapers across NixOS and Home Manager.
{pkgs, ...}: {
  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rose-pine/wallpapers/main/os/linux.jpg";
      sha256 = "sha256-OW8HujRALZ4jmJD9XGJIOc3IjRpFPmUzXY0XMsNIhCg=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    # Global font settings
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 10;
        popups = 10;
      };
    };

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "Breeze-RosePine-Dark";
      size = 24;
    };

    # Global opacity settings
    opacity = {
      applications = 1.0;
      terminal = 0.35;
      desktop = 1.0;
      popups = 1.0;
    };

    # Rules for specific applications
    targets = {
      grub.enable = false; # We use systemd-boot/lanzaboote
    };
  };
}
