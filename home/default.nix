{ pkgs, config, ... }: {
  
  programs.home-manager.enable = true;
  
  imports = [
    ./firefox
    ./starship
    ./zsh
    ./games
    ./foot
    ./nixVim
  ];

  home = {
    username = "vheac";
    homeDirectory = "/home/vheac";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      DEFAULT_USER = "$(whoami)";
    };
  };
	
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    spotify

    thunderbird
    protonmail-bridge-gui
    discord
    bitwarden
    keepassxc
    
    kate
    gimp 

    grim
    slurp

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
  
  programs.chromium = {
     enable = true;
     commandLineArgs = [
       "--enable-ozone"
       "--ozone-platform=wayland"
     ];
     extensions = [
       # ublock origin
       { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
     ];
   };

  home.stateVersion = "23.11";
 }
