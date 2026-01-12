{ pkgs, config, ... }: 
{
  
  programs.home-manager.enable = true;
  
  imports = [
    ./firefox
    ./starship
    #./zsh
    ./fish
    ./games
    #./foot
    ./ghostty
    ./alacritty
    ./nixVim
    ./tmux
    ./cli
  ];

  home = {
    username = "vheac";
    homeDirectory = "/home/vheac";
    sessionVariables = {
      EDITOR = "nvim";
      TERM = "alacritty";
      BROWSER = "firefox";
      VISUAL = "nvim";
      DEFAULT_USER = "$(whoami)";
    };
  };
	
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    #spotify
    cider-2
    ungoogled-chromium
    brave
    mullvad-browser
    vlc
    celluloid
    smile
    gowall

    thunderbird
    #protonmail-bridge-gui
    protonmail-bridge

    file-roller

    bitwarden-desktop

    discord
    qbittorrent
    kdePackages.kate
    gimp3 

    nemo
    #pcmanfm

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
    enableFishIntegration = true;
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
      cmd terminal &${pkgs.alacritty}/bin/alacritty
      set mouse
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "kubaVencel";
      user.email = "105190657+KubaVencel@users.noreply.github.com";
            
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

  # qemu 
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  home.stateVersion = "23.11";
 }
