# Common bootloader settings shared by every EFI host.
# Per-host overrides (kernelPackages, extra params) belong in
# hosts/<n>/default.nix so they can differ between desktop and laptop.
_: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  boot.loader.efi.canTouchEfiVariables = true;
}
