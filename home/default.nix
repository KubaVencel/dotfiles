{ pkgs, config, ... }: 
{
  
  programs.home-manager.enable = true;
  
  imports = [
    ./firefox
    ./starship
    ./zsh
    ./games
    ./foot
    ./nixVim
    ./cli
  ];

  home = {
    username = "vheac";
    homeDirectory = "/home/vheac";
    sessionVariables = {
      EDITOR = "nvim";
      TERM = "foot";
      BROWSER = "firefox";
      VISUAL = "nvim";
      DEFAULT_USER = "$(whoami)";
    };
  };
	
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    #spotify
    ungoogled-chromium
    vivaldi
    brave
    vlc
    celluloid
    smile

    thunderbird
    protonmail-bridge-gui
    discord
    bitwarden
    keepassxc
    
    kdePackages.kate
    gimp 

    pcmanfm
    lazygit
  ];

  # nicely reload system units when changing configs
  # and also set global session variables in a way
  # that they will also be available to user services and all started programs,
  # not just those that was started via shell
  systemd.user = {
    startServices = "sd-switch";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  services.ssh-agent.enable = true;

  programs.lf = {
    enable = true;
    settings = {
      scrolloff = 3;
    };
    keybindings = {
      D = "delete";
      "<delete>" = "delete";
      T = "trash";
      "<esc>" = "quit";
      "<enter>" = "open";
      "o" = "terminal";
    };
    extraConfig = ''
      $mkdir -p ~/.trash
      cmd trash %set -f; mv "$fx" ~/.trash
      cmd terminal &${pkgs.foot}/bin/footclient
      set mouse
    '';
  };

  programs.git = {
    enable = true;
    userName = "kubaVencel";
    userEmail = "105190657+KubaVencel@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      rebase = {
        autosquash = true;
      };
      # Unbreak mouse scrolling
      core.pager = "less -+X";
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark_v2";
      theme_background = false;
    };
  };

  programs.htop = {
    enable = true;
    settings = {
      color_scheme = 0;
      cpu_count_from_one = 0;
      delay = 15;

      highlight_base_name = 1;
      highlight_megabytes = 1;
      highlight_threads = 1;

      show_cpu_frequency = 1;
      show_cpu_temperature = 1;
    } // (with config.lib.htop; leftMeters [
      (bar "AllCPUs2")
    ]) // (with config.lib.htop; rightMeters [
      (bar "Memory")
      (bar "Swap")
      (text "Tasks")
      (text "LoadAverage")
      (text "Uptime")
      (text "Systemd")
      (text "DiskIO")
      (text "NetworkIO")
    ]);
  };
  
  home.stateVersion = "23.11";
 }
