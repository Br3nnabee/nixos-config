{ pkgs, inputs, ... }:

{
  imports = [
    ../../hardware-configuration.nix
    ../../modules/gaming.nix
    ../../modules/nvidia.nix
    ../../modules/hyprland.nix
    ../../modules/mem.nix
    ../../modules/virt.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # Networking
  networking.hostName = "cobalt";
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Time & Locale
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  # Audio (Pipewire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.wooting.enable = true;

  # XDG Portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
    xdgOpenUsePortal = true;
  };

  programs.zsh.enable = true;

  # User Account
  users.users.brenna = {
    isNormalUser = true;
    description = "Brenna";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
    ];
    shell = pkgs.zsh; # Explicitly set shell
  };

  # System-wide Packages (Core utilities only)
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    fastfetch
    gnupg
    mold
    lld
    vulkan-tools
    ntfs3g
    protonvpn-gui
    wireguard-tools
    android-tools

    (fenix.complete.withComponents [
      "cargo"
      "rustc"
      "rust-src"
      "rust-std"
      "clippy"
      "rustc-codegen-cranelift-preview"
      "llvm-tools-preview"
    ])
  ];

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  services.open-webui = {
    enable = true;
    port = 8080; # You can change this if 8080 is taken

    # This ensures the Web UI knows where to find your Ollama service
    environment = {
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      # Disabling Google Analytics for privacy
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
    };
  };

  services.gvfs.enable = true;

  # Kitty Astro Nvim
  kittyAstroNvim = {
    username = "brenna";
    nerdfont = pkgs.hack-font;
    nodePackage = pkgs.nodejs_25;
    pythonPackage = pkgs.python314;
  };

  services.flatpak.enable = true;

  # Apply overlays
  nixpkgs.overlays = [
    inputs.fenix.overlays.default
    inputs.nur.overlays.default
  ];

  # Allow unfree packages (Chrome, Nvidia, Discord, etc)
  nixpkgs.config.allowUnfree = true;

  # Flakes & Command Line Tools
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # State Version
  # DO NOT CHANGE
  system.stateVersion = "25.11";
}
