vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set number relativenumber")
vim.cmd("nnoremap <silent> <Esc> :noh<CR>")

vim.cmd("colorscheme hort_town")

vim.cmd("set scrolloff=20")

vim.o.list = true
vim.o.listchars = 'tab:>> ,lead:>,trail:<'

-- disable intern ftplugins loading
-- (Remember Ada)
vim.g.did_load_ftplugin = 0

require("config.lazy")
