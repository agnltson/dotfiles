local colors = {
  bg_0 = "#1E1412",
  bg_1 = "#2B1A18",
  bg_2 = "#3D2A27",
  bg_3 = "#4E3A36",

  fg_0 = "#C8BAA0",
  fg_1 = "#D8CBAF",
  fg_2 = "#EDE3CE",
  fg_3 = "#FAF4E8",

  red_0   = "#8C2E23",
  red_1   = "#B53F2F",
  red_2   = "#D05540",

  green_0 = "#2E5C3E",
  green_1 = "#3E7252",
  green_2 = "#57A870",

  yellow_0 = "#9C7020",
  yellow_1 = "#C99228",
  yellow_2 = "#E2B040",

  blue_0   = "#2A4D72",
  blue_1   = "#375F8A",
  blue_2   = "#5080B8",

  magenta_0 = "#7A3258",
  magenta_1 = "#9C4170",
  magenta_2 = "#C2587E",

  cyan_0 = "#2A6862",
  cyan_1 = "#388880",
  cyan_2 = "#4EAEA6",

  purple_0 = "#5C3488",
  purple_1 = "#7A4AAE",
  purple_2 = "#A06EC8",
}

local c = colors

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "hort_town"

-- ========== UI ==========
vim.api.nvim_set_hl(0, "Normal",       { fg = c.fg_2,     bg = c.bg_0 })
vim.api.nvim_set_hl(0, "NormalFloat",  { fg = c.fg_2,     bg = c.bg_1 })
vim.api.nvim_set_hl(0, "CursorLine",   { bg = c.bg_1 })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.yellow_2, bg = c.bg_1, bold = true })
vim.api.nvim_set_hl(0, "LineNr",       { fg = c.bg_3 })
vim.api.nvim_set_hl(0, "VertSplit",    { fg = c.bg_2 })
vim.api.nvim_set_hl(0, "StatusLine",   { fg = c.fg_2,     bg = c.bg_2 })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = c.fg_0,     bg = c.bg_1 })
vim.api.nvim_set_hl(0, "Visual",       { bg = c.bg_3 })
vim.api.nvim_set_hl(0, "Search",       { fg = c.bg_0,     bg = c.yellow_1, bold = true })
vim.api.nvim_set_hl(0, "IncSearch",    { fg = c.bg_0,     bg = c.yellow_2, bold = true })

-- ========== Syntax ==========
vim.api.nvim_set_hl(0, "Comment",     { fg = c.fg_0,     italic = true })
vim.api.nvim_set_hl(0, "Identifier",  { fg = c.fg_2 })
vim.api.nvim_set_hl(0, "Operator",    { fg = c.fg_1 })
vim.api.nvim_set_hl(0, "Statement",   { fg = c.red_2,     bold = true })
vim.api.nvim_set_hl(0, "Conditional", { fg = c.red_2,     bold = true })
vim.api.nvim_set_hl(0, "Repeat",      { fg = c.red_1 })
vim.api.nvim_set_hl(0, "Function",    { fg = c.cyan_2,    bold = true })
vim.api.nvim_set_hl(0, "Type",        { fg = c.yellow_2 })
vim.api.nvim_set_hl(0, "String",      { fg = c.green_2 })
vim.api.nvim_set_hl(0, "Character",   { fg = c.green_1 })
vim.api.nvim_set_hl(0, "Constant",    { fg = c.blue_2 })
vim.api.nvim_set_hl(0, "Number",      { fg = c.blue_2 })
vim.api.nvim_set_hl(0, "Boolean",     { fg = c.purple_1 })
vim.api.nvim_set_hl(0, "PreProc",     { fg = c.magenta_2, bold = true, underline = true })
vim.api.nvim_set_hl(0, "Special",     { fg = c.purple_2 })
vim.api.nvim_set_hl(0, "Underlined",  { fg = c.cyan_1,    underline = true })
vim.api.nvim_set_hl(0, "Todo",        { fg = c.bg_0,      bg = c.yellow_1, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = c.red_2 })
vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = c.yellow_2 })
vim.api.nvim_set_hl(0, "DiagnosticInfo",  { fg = c.blue_2 })
vim.api.nvim_set_hl(0, "DiagnosticHint",  { fg = c.cyan_2 })
vim.api.nvim_set_hl(0, "DiagnosticOk",    { fg = c.green_2 })

-- ========== Treesitter ==========
vim.api.nvim_set_hl(0, "@comment",      { fg = c.fg_0,     italic = true })
vim.api.nvim_set_hl(0, "@variable",     { fg = c.fg_2 })
vim.api.nvim_set_hl(0, "@operator",     { fg = c.fg_1 })
vim.api.nvim_set_hl(0, "@keyword",      { fg = c.red_2,     bold = true })
vim.api.nvim_set_hl(0, "@function",     { fg = c.cyan_2 })
vim.api.nvim_set_hl(0, "@function.call",{ fg = c.cyan_1 })
vim.api.nvim_set_hl(0, "@type",         { fg = c.magenta_1 })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = c.yellow_2 })
vim.api.nvim_set_hl(0, "@string",       { fg = c.green_2 })
vim.api.nvim_set_hl(0, "@number",       { fg = c.blue_2 })
vim.api.nvim_set_hl(0, "@boolean",      { fg = c.purple_1 })
vim.api.nvim_set_hl(0, "@constant",     { fg = c.blue_2 })
vim.api.nvim_set_hl(0, "@constant.builtin", { fg = c.purple_2 })
