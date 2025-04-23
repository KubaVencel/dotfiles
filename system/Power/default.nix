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

  # Amd CPU
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Amd GPU
  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver = {
    enable = true;
      videoDrivers = ["amdgpu"];
      };    
    hardware = {
      graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; 
      [
        amdvlk
        rocmPackages.clr
 	vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs; 
      [  
        driversi686Linux.amdvlk
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
