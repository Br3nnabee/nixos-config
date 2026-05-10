# Common bootloader settings shared by every EFI host.
# Per-host overrides (kernelPackages, extra params) belong in
# hosts/<n>/default.nix so they can differ between desktop and laptop.
{lib, ...}: {
  boot.loader.systemd-boot = {
    enable = lib.mkDefault true;
    editor = false;
    consoleMode = "max";
    configurationLimit = 10;
  };
  boot.loader.timeout = 5;
  boot.loader.efi.canTouchEfiVariables = true;
}
