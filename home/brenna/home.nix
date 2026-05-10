{user, ...}: {
  home.username = user;
  home.homeDirectory = "/home/${user}";

  imports = [
    ./gpg.nix
    ./git.nix
    ./qt.nix
    ./shell
    ./terminal
    ./editor/nvim.nix
    ./files/yazi.nix
    ./desktop
    ./packages
  ];

  gtk.gtk4.theme = null;

  home.sessionVariables = {
    FLAKE = "/home/${user}/.nixos-config";
    NH_FLAKE = "/home/${user}/.nixos-config";
    UEBERZUGPP_BACKEND = "wayland";
    PATH = "$HOME/.local/bin:$PATH";
    BROWSER = "librewolf";
    TERMINAL = "kitty";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = false;
  };

  # DO NOT CHANGE - State version controls stateful data migrations.
  home.stateVersion = "25.11";
}
