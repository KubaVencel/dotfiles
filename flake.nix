{
  inputs = {
    # Default to the nixos-unstable branch
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Latest stable branch of nixpkgs, used for version rollback
    # The current latest version is 23.11
    #nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";

      # reduces size, but may break build
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";

    agenix.url = "github:ryantm/agenix";

    nix-colors.url = "github:misterio77/nix-colors";
    
    stylix.url = "github:danth/stylix";

    prism= {
      url = "github:IogaMaster/prism";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, lanzaboote, nixvim, stylix, prism, catppuccin, agenix, nix-index-database, ... }@inputs: {
    nixosConfigurations =
      let
        makeNixosConfiguration = name: modules: nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ({ ... }: { networking.hostName = name; })
            ./system
            ./theming/stylix.nix
            home-manager.nixosModules.home-manager
          ] ++ modules;
        };
      in
      {
        fallback = makeNixosConfiguration "fallback-hostname" [ ];

        Power = makeNixosConfiguration "Power" [
          ./system/Power
          lanzaboote.nixosModules.lanzaboote
          inputs.stylix.nixosModules.stylix
        ];
        Makima = makeNixosConfiguration "Makima" [
          ./system/Makima
          lanzaboote.nixosModules.lanzaboote
          inputs.stylix.nixosModules.stylix
        ];
      };

    homeConfigurations =
      let
        makeHomeConfiguration = modules: home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home
            ./home/gui
            stylix.homeManagerModules.stylix
            prism.homeModules.prism
            #catppuccin.homeManagerModules.catppuccin
            nixvim.homeManagerModules.nixvim
            nix-index-database.hmModules.nix-index
          ] ++ modules;
        };
      in
      {
        "vheac@fallback-hostname" = makeHomeConfiguration [ ];

        "vheac@Power" = makeHomeConfiguration [
          agenix.homeManagerModules.age
          #./home/gui/hypr/Power.nix
          ./home/gui/sway/Power.nix
        ];
        "vheac@Makima" = makeHomeConfiguration [
          agenix.homeManagerModules.age
          #./home/gui/hypr/Makima.nix
          ./home/gui/sway/Makima.nix
        ];
      };
  };
}
