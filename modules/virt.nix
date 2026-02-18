{ config, pkgs, ... }:

{
  # === Virtualization Services ===
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true; # Needed for TPM emulation (Windows 11 / Modern Guests)
      # OVMF (UEFI) is now enabled by default in Unstable
    };
  };

  programs.virt-manager.enable = true;

  # === Nested Virtualization (Crucial for Proxmox) ===
  # Enables nested virtualization for Intel/AMD CPUs so Proxmox can run VMs inside the VM.
  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_amd nested=1
  '';

  # === VM Optimization ===
  boot.kernel.sysctl = {
    "vm.max_map_count" = 262144; 
  };
}
