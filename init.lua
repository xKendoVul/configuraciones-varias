vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.smartcase = true

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.cmd('packadd packer.nvim')
end

-- Configuracion de los plugins
require('packer').startup(function(use)

	use 'wbthomason/packer.nvim'
	use {"catppuccin/nvim", as = "catppuccin"}
	use 'nvim-lualine/lualine.nvim'
	use 'kyazdani42/nvim-tree.lua'  -- Explorador de archivos
	use 'akinsho/bufferline.nvim'  -- Pestañas de buffers
	use 'lewis6991/gitsigns.nvim'  -- Estado de Git
	use 'sindrets/diffview.nvim'  -- Diferencias de Git
	use 'hrsh7th/nvim-cmp'  -- Autocompletado
	use 'hrsh7th/cmp-nvim-lsp'  -- Fuente LSP para autocompletado
	use 'L3MON4D3/LuaSnip'  -- Snippets
	use 'saadparwaiz1/cmp_luasnip'  -- Integración de snippets
	use 'neovim/nvim-lspconfig'  -- Configuración de LSP
	use 'ray-x/lsp_signature.nvim'  -- Firmas de funciones
	use 'jose-elias-alvarez/null-ls.nvim'  -- Linting y formateo
	use 'kyazdani42/nvim-web-devicons'  -- Iconos para lualine y nvim-tree
	use 'nvim-lua/plenary.nvim'

end)

vim.cmd.colorscheme "catppuccin-mocha"

require('lualine').setup({
  options = {
    icons_enabled = true,  -- Habilitar iconos
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } },  -- Muestra la ruta del archivo
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
})

require('nvim-tree').setup({
  renderer = {
    icons = {
      glyphs = {
        default = '',  -- Icono por defecto
        symlink = '',  -- Icono para enlaces simbólicos
        folder = {
          arrow_closed = '',  -- Flecha para carpeta cerrada
          arrow_open = '',    -- Flecha para carpeta abierta
          default = '',       -- Icono para carpeta
          open = '',          -- Icono para carpeta abierta
          empty = '',         -- Icono para carpeta vacía
          empty_open = '',    -- Icono para carpeta vacía abierta
        },
        git = {
          unstaged = '',  -- Cambios no stageados
          staged = '',    -- Cambios stageados
          unmerged = '',  -- Conflictos de merge
          renamed = '➜',   -- Archivos renombrados
          untracked = '', -- Archivos no rastreados
          deleted = '',   -- Archivos eliminados
          ignored = '◌',   -- Archivos ignorados
        },
      },
    },
  },
})

-- Hacer el fondo transparente
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = 'none' })

-- Pestañas de buffers
require('bufferline').setup()

-- Estado de Git
require('gitsigns').setup()

-- Diferencias de Git
require('diffview').setup()

-- Configuración de LSP
local lspconfig = require('lspconfig')
lspconfig.pyright.setup({})  -- LSP para Python (puedes agregar otros lenguajes)

-- Configuración de autocompletado
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }),
})

-- Firmas de funciones
require('lsp_signature').setup()

-- Linting y formateo
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,  -- Formateador para Python
    null_ls.builtins.diagnostics.flake8,  -- Linter para Python
  },
})

-- Abrir/cerrar explorador de archivos
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Navegar entre buffers
vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })

-- Guardar y salir
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-q>', ':q<CR>', { noremap = true, silent = true })
