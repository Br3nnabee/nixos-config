{ pkgs, ... }:

{
  # Virtualization Services
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true; # Needed for TPM emulation (Windows 11 / Modern Guests)
      # OVMF (UEFI) is now enabled by default in Unstable
    };
  };

  virtualisation.docker = {
    enable = true;
  };

  programs.virt-manager.enable = true;

  # VFIO + IOMMU for PCI passthrough
  boot = {
    kernelModules = [
      "kvm-intel" # Assuming Intel CPU
      "vfio"
      "vfio_iommu_type1"
      "vfio_pci"
      "vfio_virqfd" # Optional but useful
    ];

    initrd.kernelModules = [
      "vfio"
      "vfio_iommu_type1"
      "vfio_pci"
    ];

    # Enable IOMMU + early VFIO binding for your iGPU
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt" # Passthrough mode, reduces overhead
      # Bind iGPU (and audio) to vfio-pci early
      # REPLACE with your actual IDs, comma-separated, no spaces
      "vfio-pci.ids=00:02.0,00:1f.3"
    ];

    # Prevent host from using iGPU
    blacklistedKernelModules = [ "i915" ];
  };

  boot.binfmt.emulatedSystems = [ "riscv64-linux" ];

  # Optional: Extra safety if binding fails
  boot.extraModprobeConfig = ''
    options vfio-pci 00:02.0,00:1f.3 disable_vga=1
    options kvm_intel nested=1
  '';

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };
}
