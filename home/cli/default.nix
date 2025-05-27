{ 
  config,
  pkgs,
  ... 
}: 
{
    home.packages = with pkgs; [
        lolcat
        cowsay
        cbonsai
        pipes-rs
        cmatrix
        astroterm

        starfetch
        onefetch # gitfetch
        
        gnugrep
        gnutls
        gnused
        bat

        eza
        lsd

        fd
        bc
        direnv
        nix-direnv
        cava
        killall
        libnotify
        timer
        brightnessctl
        gnugrep
        ripgrep
        rsync
        unzip
        w3m
        #pandoc
        hwinfo
        pciutils
        #numbat

        (pkgs.writeShellScriptBin "airplane-mode" ''
        #!/bin/sh
        connectivity="$(nmcli n connectivity)"
        if [ "$connectivity" == "full" ]
        then
            nmcli n off
        else
            nmcli n on
        fi
        '')
    ];
}
