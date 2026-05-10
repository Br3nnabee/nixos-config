# Enables Hyprland at the system level (kernel, portals, display manager).
_: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  # Tell Electron/Chromium apps to use the Wayland backend
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    # Force GTK and Qt apps to use Wayland natively
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };

  # Display manager - Wayland SDDM with an explicit default session so it
  # never silently falls back to a broken X11 session.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings.General.DefaultSession = "hyprland.desktop";
  };

  # Required for SDDM
  services.xserver.enable = true;
}
