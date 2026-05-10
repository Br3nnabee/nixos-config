_: {
  # Kernel Hardening settings
  boot.kernel.sysctl = {
    # ASLR hardening
    "kernel.randomize_va_space" = 2;

    # Protect against symlink attacks
    "fs.protected_fifos" = 2;
    "fs.protected_hardlinks" = 1;
    "fs.protected_regular" = 2;
    "fs.protected_symlinks" = 1;

    # Network hardening
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv4.conf.default.accept_source_route" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.tcp_timestamps" = 0; # reduce information leakage

    # Restrict dmesg access to root
    "kernel.dmesg_restrict" = 1;

    # Restrict kptr access
    "kernel.kptr_restrict" = 2;
  };

  security.apparmor = {
    enable = true;
    enableCache = true;
    killUnconfinedConfinables = true;
  };

  security.polkit.enable = true;

  security.sudo = {
    enable = true;
    extraConfig = ''
      # Provide visual feedback when typing password
      Defaults pwfeedback
      # Limit sudo attempts
      Defaults passwd_tries=5
      # Insult users on wrong password
      Defaults insults
    '';
  };

  security.auditd.enable = true;
  security.audit.enable = false; # Fails on current kernel with default rules; auditd still handles logging.

  # Use nftables for modern firewalling
  networking.nftables.enable = true;
}
