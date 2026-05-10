# Virtualisation stack: QEMU/KVM via libvirt, Docker, and Intel iGPU
# passthrough via VFIO. Only imported on cobalt (desktop).
{
  pkgs,
  user,
  ...
}: {
  # libvirt / QEMU
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = false;
      swtpm.enable = true; # TPM emulation for Windows 11 guests
      # OVMF (UEFI firmware) is enabled by default on nixos-unstable
    };
  };

  programs.virt-manager.enable = true;

  # Podman (Docker alternative)
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # provides 'docker' alias and socket
    defaultNetwork.settings.dns_enabled = true;
  };

  # User groups
  # The module system merges extraGroups lists, so this safely extends
  # whatever common/users.nix already declares.
  users.users.${user}.extraGroups = [
    "libvirtd"
    "kvm"
  ];

  # VFIO / IOMMU (Intel iGPU passthrough)
  boot = {
    kernelModules = [
      "kvm-intel"
      "vfio"
      "vfio_iommu_type1"
      "vfio_pci"
    ];

    initrd.kernelModules = [
      "vfio"
      "vfio_iommu_type1"
      "vfio_pci"
    ];

    kernelParams = [
      "intel_iommu=on"
      "iommu=pt" # passthrough mode — reduces overhead vs translation mode
      "vfio-pci.ids=8086:a780,8086:7a50"
    ];

    # Prevent the host from claiming the iGPU before VFIO can bind it
    blacklistedKernelModules = ["i915"];

    extraModprobeConfig = ''
      options vfio-pci ids=8086:a780,8086:7a50 disable_vga=1
      options kvm_intel nested=1
    '';

    kernel.sysctl."vm.max_map_count" = 2147483642; # required by some games / Wine

    # RISC-V cross-compilation / emulation support
    binfmt.emulatedSystems = ["riscv64-linux"];
  };
}
