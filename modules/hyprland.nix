{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Hint electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Display Manager (SDDM)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
}
