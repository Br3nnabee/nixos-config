# Modern CLI tools that hook into ZSH. Keeping them together means each
# tool's enableZshIntegration is visible in one place rather than scattered.
_: {
  # Better ls
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
    git = true;
  };

  # Better cat — syntax highlighting, line numbers, git diffs
  programs.bat = {
    enable = true;
  };

  # Shell history with sync, fuzzy search, and context
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # Don't sync to Atuin cloud unless you set up self-hosted
      sync_address = "";
    };
  };

  # Fuzzy finder
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Directory jumper — `z foo` to jump to a frecent dir
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Interactive tree navigator
  programs.broot = {
    enable = true;
    enableZshIntegration = true;
  };
}
