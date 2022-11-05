-- init.lua

---- helper

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- show title
opt.title = true

-- show number
opt.number=true
opt.relativenumber=true

-- show command
opt.showcmd = true

-- scroll margin
opt.scrolloff = 5

-- show cursorline
opt.cursorline = true

-- indent
opt.autoindent = true
opt.smartindent = true
opt.cindent = true

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.wrapscan = true

-- no swap and backup
opt.swapfile = false
opt.backup = false

-- hidden
opt.hidden = true

-- kill mouse
opt.mouse = ''

-- key map
g.mapleader = ' '
map('i', 'jk', '<ESC>:w<CR>')
map('n', '<Leader>%', ':source<space>%<CR>')

map('n', '<Leader><ESC>', ':nohlsearch<CR>')
map('n', 'ss', ':split<CR>')
map('n', 'sv', ':vsplit<CR>')
map('n', 'sh', '<C-w>h')
map('n', 'sj', '<C-w>j')
map('n', 'sk', '<C-w>k')
map('n', 'sl', '<C-w>l')
map('n', 'U', '<C-r>')
map('n', '+', '<C-a>')
map('n', '-', '<C-x>')
map('n', '<C-a>', 'gg<S-v>G')

-- required
map('n', '<Left>', '<C-w>h')
map('n', '<Down>', '<C-w>j')
map('n', '<Up>', '<C-w>k')
map('n', '<Right>', '<C-w>l')
map('i', '<Left>', '<None>')
map('i', '<Down>', '<None>')
map('i', '<Up>', '<None>')
map('i', '<Right>', '<None>')
map('v', '<Left>', '<None>')
map('v', '<Down>', '<None>')
map('v', '<Up>', '<None>')
map('v', '<Right>', '<None>')

-- plugin

vim.cmd('packadd vim-jetpack')
require('jetpack.packer').startup(function(use)
	use { 'tani/vim-jetpack', opt = 1 }
	use { 'easymotion/vim-easymotion' }
	use { 'morhetz/gruvbox' }
end)

-- plugin key map
map('n', '<Leader>w', '<Plug>(easymotion-overwin-w')
map('n', '<Leader>f', '<Plug>(easymotion-overwin-f')

-- colorscheme
vim.cmd 'colorscheme gruvbox'
opt.background = 'dark'
vim.cmd 'let g:gruvbox_contrast_dark = "hard"'
vim.api.nvim_set_hl(0, 'Normal', { ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'NonText', { ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'SpecialKey', { ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'LineNr', { ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'SignColumn', { ctermbg = 'NONE' })
