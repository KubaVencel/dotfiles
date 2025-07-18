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

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prism = {
      url = "github:IogaMaster/prism";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.home-manager.follows = "home-manager";
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
            ./nixModules/theming/stylix.nix
            ./nixModules/virt
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            lanzaboote.nixosModules.lanzaboote
          ] ++ modules;
        };
      in
      {
        fallback = makeNixosConfiguration "fallback-hostname" [ ];

        Power = makeNixosConfiguration "Power" [
          ./system/Power
        ];
        Makima = makeNixosConfiguration "Makima" [
          ./system/Makima
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
            ./nixModules/theming/prism.nix
            prism.homeModules.prism
            nixvim.homeManagerModules.nixvim
            nix-index-database.homeModules.nix-index
            #catppuccin.homeManagerModules.catppuccin
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
