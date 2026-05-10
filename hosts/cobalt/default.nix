{
  pkgs,
  user,
  ...
}: {
  imports = [./hardware.nix];

  # Identity
  networking.hostName = "cobalt";

  # Kernel: Zen kernel for better desktop responsiveness
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Networking: Disable reverse-path filtering for VPN routing
  networking.firewall.checkReversePath = "loose";

  # System packages (cobalt-only)
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    fastfetch
    gnupg
    mold # fast linker
    lld
    vulkan-tools
    ntfs3g
    proton-vpn
    wireguard-tools
    android-tools

    # Rust toolchain via fenix overlay
    (pkgs.lib.hiPrio (
      pkgs.fenix.latest.withComponents [
        "cargo"
        "rustc"
        "rust-src"
        "rust-std"
        "clippy"
        "rustc-codegen-cranelift-preview"
        "llvm-tools-preview"
      ]
    ))
  ];

  # Kitty + AstroNvim (upstream flake module)
  kittyAstroNvim = {
    username = user;
    nerdfont = pkgs.hack-font;
    nodePackage = pkgs.nodejs_25;
    pythonPackage = pkgs.python314;
  };

  # DO NOT CHANGE - State version
  system.stateVersion = "25.11";
}
