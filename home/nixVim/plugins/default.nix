{...}:
{
programs.nixvim = {
  plugins = {
    web-devicons.enable = true;
    nix.enable = true; # Support for writing Nix expressions in vim 

    lualine.enable = true; # A blazing fast and easy to configure Neovim statusline written in Lua.

    bufferline.enable = true; # A snazzy 💅 buffer line (with tabpage integration) for Neovim built using lua.
    
    colorizer.enable = true; # A high-performance color highlighter for Neovim which has no external dependencies! Written in performant Luajit.

    #transparent.enable = true;
    luasnip.enable = true;
    treesitter.enable = true;
    gitsigns.enable = true;
    nvim-autopairs.enable = true;
    illuminate.enable = true;

    nvim-tree = {
      enable = true;
    };

    oil = {
      enable = true;
         };
     
    telescope = {
      enable = true;
      };

    startup = {
      enable = true;
      settings.theme = "evil";
    };
    
    # Language Server Protocol 
    lsp = {
      enable = true;

      servers = {
        ts_ls.enable = true;
        nixd.enable = true;
        html.enable = true;
        cssls.enable = true;

        lua_ls = {
          enable = true;
          settings.telemetry.enable = false;
        };

        rust_analyzer = {
          installRustc = true;
          enable = true;
            installCargo = true;
          };
        };
      };
    };
  };
}
