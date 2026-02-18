{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../../hardware-configuration.nix
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

  programs.zsh.enable = true;

  # User Account
  users.users.brenna = {
    isNormalUser = true;
    description = "Brenna";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
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
  ];

  # Allow unfree packages (Chrome, Nvidia, Discord, etc)
  nixpkgs.config.allowUnfree = true;

  # Flakes & Command Line Tools
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # State Version
  # DO NOT CHANGE
  system.stateVersion = "25.11";
}
