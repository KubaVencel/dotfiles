{ 
  config,
  pkgs,
  ... 
}: 
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      package = pkgs.zsh-syntax-highlighting;
    };
    enableCompletion = true;
    dotDir = ".config/zsh";
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
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
