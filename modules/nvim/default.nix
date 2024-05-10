{ config, lib, pkgs, inputs, ... }: 
let
  unstable = import inputs.unstablepkgs {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  programs.neovim = {
    enable = true;
    plugins =  with unstable.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          local lspconfig = require("lspconfig")

          lspconfig.html.setup({ capabilities = capabilities })
          lspconfig.lua_ls.setup({ capabilities = capabilities })
          lspconfig.pyright.setup({ capabilities = capabilities })
          lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })

          vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        '';
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          vim.keymap.set("n", "<leader>o", builtin.find_files, {})
          vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        '';
      }
    ];
    extraConfig = ''
      lua << END
      vim.opt.expandtab=true      -- Convert tabs to spaces
      vim.opt.tabstop=2           -- Indent using two spaces
      vim.opt.softtabstop=2       -- make 2 spaces act like tabs
      vim.opt.shiftwidth=2       --
      vim.opt.hlsearch=true       -- highlight text when searching by default
      vim.opt.ignorecase=true     -- ignore case when searching
      vim.opt.incsearch=true      -- begin highlighting partial matches when searching
      vim.opt.smartcase=true      -- switch to case sensitive when uppercase is used
      vim.opt.linebreak=true      -- avoid wrapping in the middle of a word
      vim.opt.wrap=true           -- enable line wrapping
      vim.opt.wildmenu=true       -- Display command line's tab complete options as a menu
      --vim.opt.wildmenu=longest:full,full       -- Display command line's tab complete options as a menu
      vim.opt.title=true
      vim.opt.history=1000
      vim.opt.showcmd=true        -- show command-in-progress
      vim.opt.textwidth=80
      vim.opt.hidden=true
      
      vim.g.mapleader = " "
      
      -- Navigate vim panes better
      vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
      vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
      vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
      vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
      
      -- just some good hotkeys
      vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>') -- Turn off search hilighting
      vim.keymap.set('n', '<leader>pv', ':Vex<CR>') -- Split Vertically
      vim.keymap.set('n', '<leader>ph', ':Sex<CR>') -- Split Horizontally
      vim.keymap.set('n', '<leader>w', ':w<CR>') -- Quick Save
      
      -- Copy to clipboard
      vim.keymap.set('v', '<leader>y', '"+y')
      vim.keymap.set('n', '<leader>Y', '"+yg_')
      vim.keymap.set('n', '<leader>y', '"+y')
      vim.keymap.set('n', '<leader>yy', '"+yy')
      
      -- Paste from clipboard
      vim.keymap.set('n', '<leader>p', '"+p')
      vim.keymap.set('n', '<leader>P', '"+P')
      vim.keymap.set('v', '<leader>p', '"+p')
      vim.keymap.set('v', '<leader>P', '"+P')
      
      vim.wo.number = true
END
    '';
  };
}
