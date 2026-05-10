{pkgs, ...}: {
  home.packages = with pkgs; [
    # Productivity
    keepassxc # password manager
    foliate # e-book reader
    vlc # media player
    zenity # GTK dialog boxes (scripting helper)
    aria2 # CLI download manager
    qbittorrent # BitTorrent client

    # Communication
    vesktop # Discord client with Vencord built in

    # Desktop utilities
    ripdrag # drag-and-drop from terminal
    blueman # Bluetooth manager GUI
    grimblast # Hyprland screenshot helper
    hyprpolkitagent # Polkit agent for Hyprland

    # Hardware / engineering
    kicad # PCB design
    scrcpy # Android screen mirror over USB/Wi-Fi

    # Fonts
    nerd-fonts.hack
  ];
}
