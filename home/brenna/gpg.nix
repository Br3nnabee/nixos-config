{pkgs, ...}: {
  programs.gpg = {
    enable = true;
    settings = {
      use-agent = true;
      no-comments = true;
      with-fingerprint = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
    enableSshSupport = true;
    enableZshIntegration = true;

    # SSH key managed by GPG authentication subkey
    sshKeys = ["F0864B8705DFEDB725B406640AD05207591774F7"];

    # Cache for 1 hour, max 24 hours
    defaultCacheTtl = 3600;
    maxCacheTtl = 86400;
    defaultCacheTtlSsh = 3600;
    maxCacheTtlSsh = 86400;
  };
}
