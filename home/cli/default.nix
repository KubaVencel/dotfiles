{ 
  config,
  pkgs,
  ... 
}: 
{
    home.packages = with pkgs; [
        lolcat # Rainbows and unicorns!
        cowsay # Talking cow
        fortune # Random quotation
        cbonsai # Bonsai tree in terminal
        pipes-rs # An over-engineered rewrite of pipes.sh in Rust
        cmatrix # Digital rain
        astroterm # Planetarium for your terminal
        mapscii # Map in terminal

        starfetch # Displays constellations
        onefetch # Gitfetch
        fastfetch # System information tool

        lazygit # Tui for git

        gnugrep # Search
        gnutls # Implements the TLS/SSL
        gnused # Parse and transform text
        bat # A cat(1) clone with wings
        dysk # A linux utility listing your filesystems

        eza # A modern alternative to ls 

        tmux
        zellij

        btop # Monitor of resources 

        fd # Find
        bc # Calculator
        fzf # Fuzzy finder
        ripgrep # Search

        direnv # Shell extension that manages environment
        nix-direnv # Use_nix implementation fpr direenv
        cava # Sound visualizer
        killall # Kill processes
        libnotify # Library for sending desktop notifications
        timer # Timer...
        
        rsync # Copying tool
        unzip # Un Zip
        w3m # Text based Browser
        #pandoc
        hwinfo # Probe for the hardware present in the system
        glxinfo
        pciutils # The PCI Utilities
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
