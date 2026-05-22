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
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-buffer",
      },
      config = function()
        local cmp = require("cmp")
        cmp.setup({
          mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<CR>"]  = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<S-CR>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.abort()
              end
              fallback()
            end, { "i", "s" }),
          }),
          sources = {
            {
              name = "buffer",
              option = {
                -- pull words from all visible/loaded buffers
                get_bufnrs = function()
                  return vim.api.nvim_list_bufs()
                end,
              },
            },
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
        })
      end,
    },
  {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      telescope.load_extension("fzf")

      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      keymap("n", "<leader>ff", builtin.find_files, opts) -- <space>ff -> fichiers
      keymap("n", "<leader>fg", builtin.live_grep, opts) -- <space>fg -> grep global
      keymap("n", "<leader>fb", builtin.buffers, opts) -- <space>fb -> buffers
      keymap("n", "<leader>fr", builtin.oldfiles, opts) -- <space>fr -> récents
      keymap("n", "<leader>/", builtin.current_buffer_fuzzy_find, opts) -- <space>/  -> recherche buffer
      keymap("n", "<leader>fh", builtin.help_tags, opts)
      keymap("n", "<leader>gc", builtin.git_commits, opts) -- <space>gc -> commits git
      keymap("n", "<leader>gs", builtin.git_status, opts) -- <space>gs -> git status
      keymap("n", "<leader>ss", function()
        require("telescope.builtin").live_grep()
      end, { noremap = true, silent = true })
    end,
  },
  { "nvim-tree/nvim-web-devicons", opts = {} },
}
local opts = {}

require("lazy").setup(plugins, opts)

local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query", "elixir", "heex",
        "javascript", "html", "python", "cpp", "bash", "asm",
        "ocaml", "rust", "ada", "haskell",
    },
    highlight = {
        enable = true,
        disable = { "ada" },
    }
})
