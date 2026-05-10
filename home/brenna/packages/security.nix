# Security research / pentesting tools.
# These are intentionally kept in a separate file so they're easy to
# audit and toggle off on a machine that doesn't need them.
{pkgs, ...}: {
  home.packages = with pkgs; [
    wpscan # WordPress vulnerability scanner
  ];
}
