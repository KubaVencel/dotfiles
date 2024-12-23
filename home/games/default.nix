{
  pkgs,
  lib,
  ...
}: {
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  programs.mangohud.enable = true;

  home.packages = with pkgs; [
    #steam
    #steam-run
    protonup-ng
    steamtinkerlaunch
    er-patcher

    mangohud
    gamemode
    gamescope
    
    dxvk
    parsec-bin

    r2modman

    heroic
    lutris
    bottles
  ];
}
