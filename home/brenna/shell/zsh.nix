_: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    initContent = ''
      gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
    '';

    shellAliases = {
      ll = "eza -lh --icons --grid --group-directories-first";
      la = "eza -lah --icons --grid --group-directories-first";
      ls = "eza --icons --group-directories-first";
      tree = "eza --tree --icons";

      # Quick nix-index search (e.g. 'find-package libstdc++.so.6')
      find-package = "nix-locate --minimal --no-cache --whole-name --at-root";
    };

    history = {
      size = 50000;
      save = 50000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
    };
  };
}
