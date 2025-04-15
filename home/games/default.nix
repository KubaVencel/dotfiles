{
  pkgs,
  lib,
  ...
}: {
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  programs.mangohud = {
    enable = true;
    enableSessionWide = true; # Optional: enable for all applications
  
  # Configuration settings
    settings = {
      fps = true;
      frame_timing = true;
      cpu_stats = true;
      cpu_temp = true;
      gpu_stats = true;
      gpu_temp = true;
      ram = true;
      vram = true;
      engine_version = true;
      vulkan_driver = true;
      wine = true;
      position = "top-left";
      background_alpha = 0.5;
      font_size = 24;
      toggle_hud = "F12";  # Hotkey to toggle HUD
      no_display = true;   # Only show HUD on toggle
    };
  };

  home.packages = with pkgs; [
    steam
    steam-run

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
