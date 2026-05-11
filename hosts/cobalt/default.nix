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

  # Secure Boot with Lanzaboote
  boot.lanzaboote.enable = true;

  # Boot Aesthetics: Plymouth splash screen and quiet boot
  boot.plymouth = {
    enable = true;
  };
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "video=efifb:nobgrt"
  ];

  # Windows Dual-Boot Support
  # Since Windows is on a separate drive and its partition is NTFS,
  # we copy the Microsoft bootloader to our ESP so systemd-boot can see it.
  # We use the UUID of the "System Reserved" partition (F85AB2735AB22E6E).
  system.activationScripts.syncWindowsBoot = {
    text = ''
      WIN_PART=$(/run/current-system/sw/bin/blkid -U F85AB2735AB22E6E || true)
      if [ -n "$WIN_PART" ]; then
        mkdir -p /tmp/win-esp
        mount -o ro "$WIN_PART" /tmp/win-esp || true
        if [ -d /tmp/win-esp/EFI/Microsoft ]; then
          echo "Syncing Windows Bootloader from $WIN_PART..."
          mkdir -p /boot/EFI
          ${pkgs.rsync}/bin/rsync -a --delete /tmp/win-esp/EFI/Microsoft/ /boot/EFI/Microsoft/
        fi
        umount /tmp/win-esp || true
      fi
    '';
  };

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
