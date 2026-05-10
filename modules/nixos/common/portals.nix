# XDG desktop portal configuration.
# The Hyprland-specific portal (xdg-desktop-portal-hyprland) is enabled
# automatically by modules/nixos/desktop/hyprland.nix when imported.
{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
    xdgOpenUsePortal = true;
  };
}
