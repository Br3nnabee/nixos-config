{config, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # required for Steam / Wine 32-bit renderers
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Required for compositors and Wayland
    modesetting.enable = true;

    # Disable power management — re-enable if you experience
    # graphical corruption after suspend/resume and want to trade sleep
    # reliability for VRAM persistence to /tmp.
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Open kernel module (Turing+ GPUs only — not nouveau)
    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
