    { pkgs, config, lib, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;    
  # needed to unlock LUKS with key from TPM
  #boot.initrd.systemd.enable = true;
  
  # Steam
  programs.steam = {
    enable = true;
    #remotePlay.openFirewall = true;
    #dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Nvidia
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.blacklistedKernelModules = ["nouveau"];
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

      # Whether to enable Whether video acceleration (VA-API) should be enabled. .
      videoAcceleration = true;
      
      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement.enable = false;
      
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false; 
      
      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Do not disable this unless your GPU is unsupported or if you have a good reason to.
      open = false;
      
      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;
      
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      #package = config.boot.kernelPackages.nvidiaPackages.production;
      #package = config.boot.kernelPackages.nvidiaPackages.stable;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; 
      [
        rocmPackages.clr
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
