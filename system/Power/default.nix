    { pkgs, config, lib, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # needed to unlock LUKS with key from TPM
  boot.initrd.systemd.enable = true;
  
  # Steam
  programs.steam = {
    enable = true;
    #remotePlay.openFirewall = true;
    #dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  # Nvidia
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "nvidia-x11"
    "nvidia-settings"
    "nvidia-persistenced" 
  ];

  services.xserver = {
    enable = true;
    videoDrivers = [
      "nvidia"
    ];
  };

  hardware = {
    nvidia = {
      # nvidia-drm.modeset=1
      modesetting.enable = true;

      #forceFullCompositionPipeline = true;

      # Allow headless mode
      nvidiaPersistenced = true;

      powerManagement.enable = true;
      powerManagement.finegrained = false; 
      open = false;

      #package = config.boot.kernelPackages.nvidiaPackages.production;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      #package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; 
      [ 
 	vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

 # lanzaboote

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
}
