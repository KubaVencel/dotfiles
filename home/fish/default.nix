{ 
  config,
  pkgs,
  ... 
}: 
{
  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = {
        description = "Greeting to show when starting a fish shell";
        body = "fortune | cowsay -f eyes | lolcat";
      };
    };

    interactiveShellInit = ''
     set fish_greeting 
    '';

    shellAliases = {
      ls = "eza --icons";
      ll = "eza --icons -l";
      
      cat = "bat";
      fd = "fd -Lu";
      w3m = "w3m -no-cookie -v";
      neofetch = "fastfetch";
      fetch = "fastfetch";
      gitfetch = "onefetch";

      # Update
      update = "nix flake update";
      upgrade = "sudo nixos-rebuild switch --flake .";
      upgradeHm = "home-manager switch --flake .";
      
      upgradeAll = "nix flake update && sudo nixos-rebuild switch --flake . && home-manager switch --flake .";

      # nixDeleteOld => nixOptimise
      # garbageDay => nixOptimise

      # Agresive clean
      garbageDay = "sudo nix-collect-garbage -d";

      # Cleanup (monthly or when needed)
      nixDeleteOld = "sudo nix-collect-garbage --delete-older-than 2d";
      nixOptimise = "sudo nix-store --optimise";
      
      # Maintenance
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
