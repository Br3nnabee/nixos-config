_: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    initContent = ''
      gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
    '';

    shellAliases = {
      ll = "ls -l";
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
