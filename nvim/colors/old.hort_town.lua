local colors = {
  bg_0 = "#1E1412",
  bg_1 = "#2B1A18",
  bg_2 = "#46312F",
  bg_3 = "#4B3A35",

  fg_0 = "#D5C8AE",
  fg_1 = "#E0D2B8",
  fg_2 = "#F1E8D5",
  fg_3 = "#FAF4E8",

  red_0     = "#8C2E23",
  red_1     = "#B53F2F",
  red_2     = "#D1533E",

  green_0   = "#325F45",
  green_1   = "#3F6E52",
  green_2   = "#59A273",

  yellow_0  = "#A47A28",
  yellow_1  = "#D29B31",
  yellow_2  = "#E4B94C",

  blue_0    = "#2A496B",
  blue_1    = "#35597C",
  blue_2    = "#4F7FB5",

  magenta_0 = "#6F3240",
  magenta_1 = "#8E3F50",
  magenta_2 = "#944356",

  cyan_0    = "#316C67",
  cyan_1    = "#3F8A84",
  cyan_2    = "#56B0A8",

  purple_0  = "#7A3E96",
  purple_1  = "#9A59B6",
  purple_2  = "#B67EC7",
}

local c = colors

-- clear highlights
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "hort_town"

-- ========== UI ==========
vim.api.nvim_set_hl(0, "Normal",       { fg = c.fg_2, bg = c.bg_0 })
vim.api.nvim_set_hl(0, "NormalFloat",  { fg = c.fg_2, bg = c.bg_1 })
vim.api.nvim_set_hl(0, "CursorLine",   { bg = c.bg_1 })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.yellow_2, bg = c.bg_1, bold = true })
vim.api.nvim_set_hl(0, "LineNr",       { fg = c.bg_3 })
vim.api.nvim_set_hl(0, "VertSplit",    { fg = c.bg_2 })
vim.api.nvim_set_hl(0, "StatusLine",   { fg = c.fg_2, bg = c.bg_2 })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = c.fg_0, bg = c.bg_1 })
vim.api.nvim_set_hl(0, "Visual",       { bg = c.bg_2 })
vim.api.nvim_set_hl(0, "Search",       { fg = c.bg_0, bg = c.yellow_1, bold = true })
vim.api.nvim_set_hl(0, "IncSearch",    { fg = c.bg_0, bg = c.yellow_2, bold = true })

-- ========== Syntax ==========
vim.api.nvim_set_hl(0, "Comment",    { fg = c.fg_0, italic = true })
vim.api.nvim_set_hl(0, "Constant",   { fg = c.cyan_2 })
vim.api.nvim_set_hl(0, "String",     { fg = c.green_2 })
vim.api.nvim_set_hl(0, "Character",  { fg = c.green_1 })
vim.api.nvim_set_hl(0, "Number",     { fg = c.purple_2 })
vim.api.nvim_set_hl(0, "Boolean",    { fg = c.purple_1 })
vim.api.nvim_set_hl(0, "Identifier", { fg = c.blue_2 })
vim.api.nvim_set_hl(0, "Function",   { fg = c.blue_1, bold = true })
vim.api.nvim_set_hl(0, "Statement",  { fg = c.red_2, bold = true })
vim.api.nvim_set_hl(0, "Conditional",{ fg = c.red_1, bold = true })
vim.api.nvim_set_hl(0, "Repeat",     { fg = c.red_1 })
vim.api.nvim_set_hl(0, "Operator",   { fg = c.magenta_2 })
vim.api.nvim_set_hl(0, "PreProc",    { fg = c.yellow_2 })
vim.api.nvim_set_hl(0, "Type",       { fg = c.magenta_1 })
vim.api.nvim_set_hl(0, "Special",    { fg = c.cyan_1 })
vim.api.nvim_set_hl(0, "Underlined", { fg = c.blue_2, underline = true })
vim.api.nvim_set_hl(0, "Todo",       { fg = c.bg_0, bg = c.yellow_1, bold = true })

-- ========== LSP Diagnostics ==========
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = c.red_2 })
vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = c.yellow_2 })
vim.api.nvim_set_hl(0, "DiagnosticInfo",  { fg = c.blue_2 })
vim.api.nvim_set_hl(0, "DiagnosticHint",  { fg = c.cyan_2 })
vim.api.nvim_set_hl(0, "DiagnosticOk",    { fg = c.green_2 })

-- ========== Treesitter ==========
vim.api.nvim_set_hl(0, "@function", { fg = c.blue_2 })
vim.api.nvim_set_hl(0, "@variable", { fg = c.fg_2 })
vim.api.nvim_set_hl(0, "@keyword", { fg = c.red_1, bold = true })
vim.api.nvim_set_hl(0, "@string", { fg = c.green_2 })
vim.api.nvim_set_hl(0, "@number", { fg = c.purple_2 })
vim.api.nvim_set_hl(0, "@boolean", { fg = c.purple_1 })
vim.api.nvim_set_hl(0, "@comment", { fg = c.fg_0, italic = true })
vim.api.nvim_set_hl(0, "@type", { fg = c.magenta_1 })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = c.yellow_2 })
vim.api.nvim_set_hl(0, "@constant", { fg = c.cyan_2 })
vim.api.nvim_set_hl(0, "@operator", { fg = c.green_2 })
