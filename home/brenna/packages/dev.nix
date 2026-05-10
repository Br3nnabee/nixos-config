# Development tools. The Rust toolchain is a system package on cobalt
# (hosts/cobalt/default.nix) because it uses the fenix overlay at system
# scope. Language version managers (mise) live here at user scope.
{pkgs, ...}: {
  home.packages = with pkgs; [
    # Version management
    mise # polyglot runtime version manager (replaces asdf/nvm/pyenv)

    # GitHub
    gh # GitHub CLI
    gh-dash # TUI dashboard for PRs and issues

    # Git extras
    delta # beautiful git diffs (set as git core.pager)

    # Build / link
    patchelf # rewrite ELF RPATHs — useful for pre-built binaries
    wasm-pack

    # Misc
  ];
}
