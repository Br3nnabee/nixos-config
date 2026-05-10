# All nixpkgs-level configuration lives here so there is exactly one
# place to look when tracking what touches the package set.
{inputs, ...}: {
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    # Nightly / beta Rust toolchains via fenix
    inputs.fenix.overlays.default

    # Community packages (NUR)
    inputs.nur.overlays.default

    # zjstatus wasm binary — resolved at eval time against the locked input
    (_final: prev: {
      zjstatus = inputs.zjstatus.packages.${prev.stdenv.hostPlatform.system}.default;
    })

    # openldap's test017-syncreplication-refresh is timing-sensitive and fails
    # non-deterministically on slow/sandboxed hosts, breaking the Lutris FHS
    # build chain (lutris → openldap-i686).
    # Track: https://github.com/NixOS/nixpkgs/pull/515956
    # Remove once a fix lands in nixos-unstable.
    (_final: prev: {
      openldap = prev.openldap.overrideAttrs (_: {
        doCheck = false;
      });
    })
  ];
}
