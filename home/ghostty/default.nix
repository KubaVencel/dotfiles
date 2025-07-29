{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.ghostty.enable = true;
  programs.ghostty = {  
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
}
