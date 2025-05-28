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

        fd
        bc
        fzf
        ripgrep

        lazygit

        direnv
        nix-direnv
        cava
        killall
        libnotify
        timer
        brightnessctl
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
