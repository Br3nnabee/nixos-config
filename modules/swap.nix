{ config, lib, pkgs, ... }:

{
  # === ZRAM (24 GB uncompressed capacity) ===
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryMax = 24 * 1024 * 1024 * 1024;
    priority = 100;
    swapDevices = 1;
  };

  # === 8 GB disk swapfile (fallback) ===
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;           # Size in MiB (8 GB)
      priority = -2;             # Lower priority than zRAM
    }
  ];

  # === High swappiness + zRAM-friendly VM tunables ===
  boot.kernel.sysctl = {
    "vm.swappiness" = 100;
    # Prevents stalls, improves reclaim:
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 200;
    "vm.page-cluster" = 0;
    "vm.dirty_ratio" = 60;
    "vm.dirty_background_ratio" = 30;
  };

  # === Disable zswap ===
  # zswap + zRAM is redundant and can cause conflicts
  boot.kernelParams = [ "zswap.enabled=0" ];

  # === RAMDisk ===
  # Will be used for compilation primarily
  fileSystems."/mnt/ramdisk" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "size = 32G" "mode = 1777" "nosuid" "nodev" "nofail" ];
  };
}
