-- ~/.config/nvim/init.lua

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local o = vim.o
o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.number = true
o.relativenumber = true
o.scrolloff = 10
o.clipboard = "unnamedplus"
o.list = true
o.listchars = "tab:>> ,lead:>,trail:<"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

pcall(vim.cmd.colorscheme, "hort_town")

------------------------------------------------------------
-- 2. Plugins
------------------------------------------------------------
-- Runs after a plugin is installed or updated: telescope-fzf-native has to be
-- compiled with `make` (this is the equivalent of the `build = "make"` option in lazy.nvim).
-- It must be defined before vim.pack.add.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local d = ev.data
    if d.spec.name == "telescope-fzf-native.nvim"
        and (d.kind == "install" or d.kind == "update")
        and vim.fn.executable("make") == 1 then
      vim.system({ "make" }, { cwd = d.path }):wait()
    end
  end,
})

-- Update : :lua vim.pack.update()
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",                    -- library required by telescope
  "https://github.com/nvim-telescope/telescope.nvim",            -- fuzzy finder (files, grep, buffers...)
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim", -- faster sorting for telescope (optional)
  "https://github.com/nvim-tree/nvim-web-devicons",              -- file icons (needs a Nerd Font in the terminal)
  "https://github.com/neovim/nvim-lspconfig",                    -- ready-made configurations for LSP servers
  "https://github.com/stevearc/oil.nvim",                        -- file explorer where a directory is an editable buffer
})

------------------------------------------------------------
-- 3. Telescope
------------------------------------------------------------
local telescope = require("telescope")
telescope.setup({})
pcall(telescope.load_extension, "fzf") -- ignored if fzf-native has not been compiled

local builtin = require("telescope.builtin")
local map = vim.keymap.set
map("n", "<leader>ff", builtin.find_files, { desc = "Files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Grep inside project" })
map("n", "<leader>fb", builtin.buffers, { desc = "Open buffers" })
map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Neovim Help" })
map("n", "<leader>fd", builtin.diagnostics, { desc = "Errors / warnings" })
map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Buffer search" })
map("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
map("n", "<leader>gs", builtin.git_status, { desc = "Git status" })

------------------------------------------------------------
-- 4. Oil (file explorer)
------------------------------------------------------------
-- Oil shows a directory as a normal buffer: you edit it like text, then save with :w
-- to apply the changes on disk.
--   rename a file : change its name on the line
--   delete a file : delete its line (dd)
--   create a file : add a new line with the name (end with / for a directory)
--   move a file   : cut the line (dd) and paste it (p) in another Oil buffer
-- Inside an Oil buffer: <CR> opens the entry, - goes to the parent directory,
-- g. toggles hidden files, g? shows all the mappings.
require("oil").setup({
  -- Use Oil instead of netrw (the built-in explorer) when opening a directory, e.g. `nvim .`
  default_file_explorer = true,
})
-- Press "-" in any buffer to open the directory of the current file
map("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory (Oil)" })
-- Ctrl-c to exit oil.

------------------------------------------------------------
-- 5. Autocomplete
------------------------------------------------------------
o.autocomplete = true
o.complete = ".,w,b,u"
o.completeopt = "menu,menuone,noselect,fuzzy"
-- Navigation : Ctrl-n / Ctrl-p. Ok : Ctrl-y.

-- LSP completion (object members, functions, imports...) in addition to the buffer words.
-- To DISABLE it: comment the "= true" line, uncomment the "= false" line, restart nvim.
local lsp_completion = true
-- local lsp_completion = false

-- Turn autocomplete off in Telescope.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function(ev)
    vim.bo[ev.buf].autocomplete = false
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    if not lsp_completion then return end
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- ruff provides no completion: only enable it for servers that support it
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

------------------------------------------------------------
-- 6. LSP + diagnostics
------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { border = "rounded" },
})
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Error details" })
map("n", "<leader>cf", function() vim.lsp.buf.format() end, { desc = "Format" })
-- ]d / [d (next / previous error),
-- K (doc), grn (rename), gra (code action), grr (references), gri (implementations)

-- ruff only does linting and formatting: disable its hover so it does not
-- duplicate the one from basedpyright.
vim.lsp.config("ruff", {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
})

-- basedpyright checks types. "standard" is less noisy than its default mode.
vim.lsp.config("basedpyright", {
  settings = { basedpyright = { analysis = { typeCheckingMode = "standard" } } },
})

-- lspconfig name -> program to install. A server is only enabled
-- if its program is found in the PATH.
local servers = {
  ruff = "ruff",                           -- Python (lint/format)
  basedpyright = "basedpyright-langserver", -- Python (types)
  clangd = "clangd",                       -- C / C++
  rust_analyzer = "rust-analyzer",         -- Rust
  ocamllsp = "ocamllsp",                   -- OCaml
}
for name, bin in pairs(servers) do
  if vim.fn.executable(bin) == 1 then
    vim.lsp.enable(name)
  end
end
