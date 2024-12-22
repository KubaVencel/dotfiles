{
 ...
}:
{
programs.nixvim = {
  enable = true;

  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavor = "mocha";
      transparent_mode = true;
    };
  };

  opts = {
    number = true; # Show line numbers
    relativenumber = true; # Show relative line numbers
    incsearch = true;
    title = true;
      
#    scrolloff = 3;
#    textwidth = 100;
#    cursorline = true;
#    cursorcolumn = true;
#    termguicolors = true;
#    background = "dark";
#    showmode = false;
  
    shiftwidth = 2; # Tab width should be 2
    };

    plugins = {
      web-devicons.enable = true;
    nix.enable = true; # Support for writing Nix expressions in vim 

    lualine.enable = true; # A blazing fast and easy to configure Neovim statusline written in Lua.

    bufferline.enable = true; # A snazzy 💅 buffer line (with tabpage integration) for Neovim built using lua.
    
    colorizer.enable = true; # A high-performance color highlighter for Neovim which has no external dependencies! Written in performant Luajit.

    transparent.enable = true;
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
      theme = "evil";
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
     
    # A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and "sourced".
    cmp = {
        enable = true;

        settings = {
          snippet.expand = "function(args) require'luasnip'.lsp_expand(args.body) end";

          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "treesitter"; }
          ];

          mapping = {
            "<CR>" = "cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace }";
            "<Tab>" = ''
              cmp.mapping(
                function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif require'luasnip'.expand_or_jumpable() then
                    require'luasnip'.expand_or_jump()
                  else
                    fallback()
                  end
                end,
                {'i', 's'}
              )
            '';
            "<S-Tab>" = ''
              cmp.mapping(
                function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif require'luasnip'.jumpable(-1) then
                    require'luasnip'.jump(-1)
                  else
                    fallback()
                  end
                end,
                {'i', 's'}
              )
            '';
            "<C-e>" = "cmp.mapping.abort()";
            "<C-Space>" = "cmp.mapping.complete";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f" = "cmp.mapping.scroll_docs(4)";
          };
        };
      };
    };
  };
}
