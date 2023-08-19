{ config, lib, pkgs, ... }: {
  imports = [
    ./keymaps.nix
    ./alpha.nix
  ];
  programs.nixvim = {
    enable = true;
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      integrations.which_key = true;
    };
    options = {
      number = true;
      relativenumber = true;
      termguicolors = true;
    };
    plugins = {
      which-key = {
        enable = true;
        icons = {
          breadcrumb = "»";
          separator = "➜";
          group = "+";
        };
      };
      copilot-lua = {
        enable = true;
        suggestion.enabled = true;
      };
      treesitter = {
        enable = true;
        indent = true;
      };
      treesitter-context.enable = true;
      treesitter-refactor.enable = true;
      lspkind = {
        enable = true;
        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            treesitter = "[TS]";
            nvim_lua = "[LUA]";
            buffer = "[BUF]";
            path = "[PATH]";
          };
        };
      };
      nvim-cmp = {
        enable = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "treesitter"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "calc"; }
        ];
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            modes = [ "i" "s" ];
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expandable() then
                  luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                elseif check_backspace() then
                  fallback()
                else
                  fallback()
                end
              end
            '';
          };
        };
      };
      lsp = {
        enable = true;
        servers = {
          pylsp = {
            enable = true;
            settings.plugins = {
              pyflakes.enabled = true;
            };
          };
          nixd.enable = true;
          tsserver.enable = true;
        };
      };
      nix.enable = true;
      nvim-jdtls = {
        enable = true;
        configuration = "/home/maxh/.cache/jdtls/config";
        data = "/home/maxh/.cache/jdtls/workspace";
      };
      nvim-autopairs.enable = true;
      project-nvim.enable = true;
      telescope = {
        enable = true;
        extensions = {
          project-nvim.enable = true;
        };
      };
      leap.enable = true;
      bufferline = {
        enable = true;
        showCloseIcon = false;
      };
      auto-session.enable = true;
      chadtree.enable = true;
      comment-nvim.enable = true;
      toggleterm = {
        enable = true;
        insertMappings = false;
        openMapping = "<leader>ot";
        terminalMappings = false;
      };
    };
    extraPlugins = [
      pkgs.vimPlugins.lazygit-nvim
    ];
  };
}
