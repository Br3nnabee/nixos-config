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

  # XDG
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
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
    qemu_kvm
    virt-manager
    libvirt
    gnupg
    mold
    lld

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

  environment.sessionVariables = {
    # Force Vulkan loader to see NVIDIA ICDs
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json:/run/opengl-driver-32/share/vulkan/icd.d/nvidia_icd.json";
    # Helpful for offload
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
  };

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
