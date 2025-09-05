vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set number relativenumber")
vim.cmd("nnoremap <silent> <Esc> :noh<CR>")

vim.cmd("colorscheme hort_town")

vim.o.list = true
vim.o.listchars = 'tab:>> ,lead:>,trail:<'

require("config.lazy")
