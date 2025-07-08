{ 
  config,
  pkgs,
  ... 
}: 
{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --icons";
      ll = "eza --icons -l";
      
      cat = "bat";
      fd = "fd -Lu";
      w3m = "w3m -no-cookie -v";
      neofetch = "fastfetch";
      fetch = "fastfetch";
      gitfetch = "onefetch";

      update = "nix flake update";
      upgrade = "sudo nixos-rebuild switch --flake .";
      upgradeHm = "home-manager switch --flake .";
      garbageDay = "sudo nix-collect-garbage -d";
      storeGarbage = "sudo nix-store --gc --print-dead";
      nixDeleteOld = "nix-env --delete-generations";
      storeRepair = "sudo nix-store --verify --check-contents --repair";
    };
    plugins = [
        { 
          name = "grc"; src = pkgs.fishPlugins.grc.src; }
        {
          name = "autopair";
          src = pkgs.fishPlugins.autopair;
        }
        {
          name = "done";
          src = pkgs.fishPlugins.done;
        }
        {
          name = "fzf-fish";
          src = pkgs.fishPlugins.fzf-fish;
        }
        {
          name = "forgit";
          src = pkgs.fishPlugins.forgit;
        }
        {
          name = "tide";
          src = pkgs.fishPlugins.tide;
        }
        {
          name = "sponge";
          src = pkgs.fishPlugins.sponge;
        }
        {
          name = "wakatime";
          src = pkgs.fishPlugins.wakatime-fish;
        }
        {
          name = "z";
          src = pkgs.fishPlugins.z;
        }
      ];
  };
}
