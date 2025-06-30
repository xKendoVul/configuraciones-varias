local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.autoindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.encoding = "utf-8"
opt.visualbell = true
opt.scrolloff = 5

require("kendov.plugins")
require("kendov.lsp")
require("kendov.cmp")
require("kendov.keymaps")
require("statusline")
require("nvimtree")

vim.cmd.colorscheme("catppuccin")

require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "javascript", "lua", "bash", "json" },
  highlight = { enable = true },
})

