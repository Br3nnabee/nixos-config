# Memory subsystem tuning: ZRAM (primary swap), disk swapfile (fallback),
# VM kernel parameters, and a large tmpfs ramdisk for compilation.
# Only imported on cobalt (desktop) - the laptop will need its own profile.
_: {
  # ZRAM (primary swap, ~24 GB uncompressed capacity at 50 %)
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
    swapDevices = 1;
  };

  # Disk swapfile (cold fallback)
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024; # MiB
      priority = -2; # always prefer ZRAM
    }
  ];

  # VM tunables
  boot.kernel.sysctl = {
    "vm.swappiness" = 80; # lean hard on ZRAM
    "vm.watermark_boost_factor" = 0; # avoid reclaim stalls
    "vm.watermark_scale_factor" = 200;
    "vm.page-cluster" = 0; # single-page reads — ideal for ZRAM
    "vm.dirty_ratio" = 60;
    "vm.dirty_background_ratio" = 30;
    "vm.vfs_cache_pressure" = 50;
  };

  # zswap + ZRAM is redundant and can cause subtle conflicts
  boot.kernelParams = ["zswap.enabled=0"];

  # tmpfs for /tmp
  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "50%";
  };

  # RAMDisk for compilation
  # Mount a large tmpfs at /mnt/ramdisk and point CARGO_TARGET_DIR / similar
  # env vars here to keep build artefacts out of the Nix store and off disk.
  fileSystems."/mnt/ramdisk" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [
      "size=45G"
      "mode=1777"
      "nosuid"
      "nodev"
      "nofail" # don't block boot if mount fails
    ];
  };
}
