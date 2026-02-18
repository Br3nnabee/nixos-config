{ config, lib, pkgs, ... }:

{
  # === ZRAM (24 GB uncompressed capacity) ===
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryMax = 24 * 1024 * 1024 * 1024;
    priority = 1000;
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

  # === Low swappiness + zRAM-friendly VM tunables ===
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    # Prevents stalls, improves reclaim:
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

  # === Disable zswap ===
  # zswap + zRAM is redundant and can cause conflicts
  boot.kernelParams = [ "zswap.enabled=0" ];
}
