_: let
  kovaaksPath = ".local/share/Steam/steamapps/common/FPSAimTrainer/FPSAimTrainer";
in {
  home.file."${kovaaksPath}/Saved/SaveGames/Themes" = {
    source = ./files/Themes;
    recursive = true;
  };

  # Core Config Files
  home.file."${kovaaksPath}/Saved/SaveGames/PrimaryUserSettings.json".source =
    ./files/Config/PrimaryUserSettings.json;
  home.file."${kovaaksPath}/Saved/SaveGames/FovSensConfig.json".source =
    ./files/Config/FovSensConfig.json;
  home.file."${kovaaksPath}/Saved/SaveGames/UI.json".source = ./files/Config/UI.json;
  home.file."${kovaaksPath}/Saved/SaveGames/weaponsettings.ini".source =
    ./files/Config/weaponsettings.ini;

  home.file."${kovaaksPath}/crosshairs" = {
    source = ./files/Crosshairs;
    recursive = true;
  };

  home.file."${kovaaksPath}/sounds" = {
    source = ./files/Sounds;
    recursive = true;
  };
}
