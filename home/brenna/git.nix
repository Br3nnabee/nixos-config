_: {
  programs.git = {
    enable = true;

    signing = {
      key = "1CAFECB4EB3B3238";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Br3nnabee";
        email = "contact@br3nnabee.dev";
      };

      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
