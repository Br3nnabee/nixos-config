{pkgs, ...}: {
  # LibreWolf standard settings via Home Manager
  programs.librewolf = {
    enable = true;

    # Required for the KeePassXC extension to talk to the local app
    nativeMessagingHosts = [pkgs.keepassxc];

    profiles.brenna = {
      isDefault = true;
      settings = {
        # --- Fingerprinting & Usability ---
        "privacy.resistFingerprinting" = true; # Re-enable RFP for maximum privacy
        "privacy.resistFingerprinting.letterboxing" = false; # Keep letterboxing off
        "webgl.disabled" = false; # Allow WebGL for site compatibility

        # --- Persistence (Stay logged in) ---
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.downloads" = false;
        "privacy.clearOnShutdown.sessions" = false;
        "privacy.clearOnShutdown.siteSettings" = false;

        # --- Extension Management ---
        "extensions.autoDisableScopes" = 0; # Don't disable "sideloaded" (Nix) extensions
        "extensions.enabledScopes" = 15;
        "extensions.update.enabled" = false;

        # --- Performance & Wayland ---
        "gfx.webrender.all" = true;
        "layers.acceleration.force-enabled" = true;
        "widget.wayland.fractional-scale-enabled" = true;
        "widget.content.allow-gtk-dark-theme" = true;

        # --- Privacy & Connectivity ---
        "media.peerconnection.enabled" = false; # Disable WebRTC to prevent VPN leaks
        "privacy.firstparty.isolate" = false; # Stronger cookie isolation
        "network.trr.mode" = 2; # DNS-over-HTTPS (DoH) with system fallback
        "network.trr.uri" = "https://dns.quad9.net/dns-query";

        # --- UI Preferences ---
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.tabs.closeTabByDoubleClick" = true;
        "browser.newtabpage.enabled" = false;
        "browser.uidensity" = 1; # Enable Compact Mode
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Enable userChrome.css support
      };

      # Managed extensions via NUR
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        keepassxc-browser
        darkreader
        ublock-origin
      ];
    };
  };

  # Stylix theming for Librewolf
  stylix.targets.librewolf.profileNames = ["brenna"];

  # Use overrides only for persistence and extension fixes.
  home.file.".librewolf/librewolf.overrides.cfg".text = ''
    // First line must be a comment.
    pref("privacy.sanitize.sanitizeOnShutdown", false);
    pref("privacy.clearOnShutdown.history", false);
    pref("privacy.clearOnShutdown.cookies", false);
    pref("privacy.clearOnShutdown.siteSettings", false);
    pref("privacy.clearOnShutdown.offlineApps", false);
    pref("privacy.clearOnShutdown.sessions", false);
    pref("network.cookie.lifetimePolicy", 0);
    pref("extensions.autoDisableScopes", 0);
    pref("extensions.enabledScopes", 15);
  '';
}
