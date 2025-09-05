-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim

local plugins = {
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"folke/which-key.nvim",
    event = "VeryLazy",  -- Exécute which-key après que Neovim soit prêt ou après un événement spécifique
    -- Ajouter des mappages spécifiques pour les touches de raccourcis
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({
                        global = false,
                        loop = true,
                    })
            end,
            desc = "Buffer Local Keymaps (which-key)",
            },
        },
    -- Configuration complète pour which-key
    --config = function()
      --require("which-key").setup {
        --win = {
          --border = "rounded",   -- Bordure arrondie
          --position = "bottom",  -- Position en bas
          --margin = { 1, 0, 1, 0 },  -- Marges
          --padding = { 2, 2, 2, 2 }, -- Espacement interne
          --winblend = 100,        -- Transparence
        --},
        --layout = {
          --height = { min = 4, max = 15 },  -- Limiter la hauteur
          --width = { min = 20, max = 50 },  -- Limiter la largeur
          --spacing = 3,  -- Espacement entre les colonnes
          --align = "center", -- Alignement des colonnes
        --},
        -- Autres configurations optionnelles ici
      --}
    --end
    -- Show hydra mode for changing windows
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer", -- Complétion à partir du buffer
            "hrsh7th/cmp-path", -- Complétion des chemins de fichiers
            "hrsh7th/cmp-nvim-lsp", -- Intégration avec LSP
            "neovim/nvim-lspconfig", -- Serveurs LSP
        },
        config = function()
            local cmp = require'cmp'

            cmp.setup({
                snippet = {
                    -- Désactiver les snippets
                    expand = function(args)
                        -- Aucun snippet n'est activé ici
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                  }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' }, -- Complétion via LSP
                    { name = 'buffer' }, -- Complétion depuis le buffer
                    { name = 'path' }, -- Complétion des chemins de fichiers
                }),
            })
            -- Complétion dans la ligne de commande (par exemple : pour `:`)
            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'path' },
                    { name = 'cmdline' }
                })
            })
        end,
    },
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end
    },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clangd", "cmake", "ocamllsp"}
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      lspconfig.lua_ls.setup({})
      lspconfig.clangd.setup({})
      lspconfig.cmake.setup({})
      lspconfig.gdscript.setup(capabilities)
      lspconfig.ocamllsp.setup(capabilities)
      lspconfig.asm_lsp.setup(capabilities)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    end
  },
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end
  }
}
local opts = {}

require("lazy").setup(plugins, opts)

local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "python", "cpp", "bash", "asm", "ocaml", "javascript" },
    auto_install = true,
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = false },
})
