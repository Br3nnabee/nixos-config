{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  config = lib.mkIf config.boot.lanzaboote.enable {
    environment.systemPackages = [
      pkgs.sbctl
    ];

    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.lanzaboote = {
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
