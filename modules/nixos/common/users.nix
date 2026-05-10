# Declares the primary user account.
# Modules that introduce additional groups (libvirtd, docker, kvm) append
# to extraGroups themselves — the module system merges listOf options from
# all imported modules, so each feature module is self-contained.
{
  user,
  pkgs,
  ...
}: {
  programs.zsh.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    description = user;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "render"
    ];
  };
}
