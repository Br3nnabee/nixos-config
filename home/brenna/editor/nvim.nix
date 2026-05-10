# Base neovim enablement. The full AstroNvim config is provided by the
# kitty-astro-nvim nixosModule (system-level) - this module just ensures
# Home Manager also knows neovim is the preferred editor.
_: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withRuby = false;
    withPython3 = false;
  };
}
