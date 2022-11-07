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

-- plugin

cmd('packadd vim-jetpack')
require('jetpack.packer').startup(function(use)
	use { 'tani/vim-jetpack', opt = 1 }-- bootstrap
	use { 'morhetz/gruvbox' }-- color scheme
	use { 'phaazon/hop.nvim' }-- easymotion
	use { 'f-person/git-blame.nvim' }-- git blame
	use { 'kyazdani42/nvim-web-devicons' }-- required buffer line
	use { 'BurntSushi/ripgrep' }-- required telescope
	use { 'nvim-lua/plenary.nvim' }-- required telescope
	use { 'sharkdp/fd' }-- required telescope
	use { 'nvim-telescope/telescope.nvim' }-- high performance file searcher
	use { 'nvim-telescope/telescope-file-browser.nvim' }-- telescope extension
	use { 'windwp/nvim-ts-autotag' }-- powerfull typescript auto tag
	use { 'windwp/nvim-autopairs' }-- powerfull () {} []
	use { 'nvim-treesitter/nvim-treesitter' }-- parsing
	use { 'neovim/nvim-lspconfig' }-- neovim builtin LSP
	use { 'williamboman/mason.nvim' }-- neovim builtin LSP
	use { 'williamboman/mason-lspconfig.nvim' }-- neovim builtin LSP
	use { 'hrsh7th/nvim-cmp' }-- LSP complement
	use { 'hrsh7th/cmp-nvim-lsp' }-- LSP complement src
	use { 'hrsh7th/cmp-vsnip' }-- LSP snip
	use { 'hrsh7th/cmp-buffer' }-- LSP buffer cmp
	use { 'hrsh7th/vim-vsnip' }-- LSP snip
	use { 'kkharji/lspsaga.nvim' }-- LSP powerfull gui
	use { 'ray-x/lsp_signature.nvim' }-- LSP cmp powerfull gui
	use { 'onsails/lspkind.nvim' }-- LSP cmp icon
	use { 'j-hui/fidget.nvim' }-- LSP show running progress
end)

---- hop.nvim

local hopStatus, hop = pcall(require, "hop")
if (not hopStatus) then return end

hop.setup()

map('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>")
map('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>")
map('n', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>")
map('n', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>")
map('v', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>")
map('v', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>")
map('v', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>")
map('v', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>")
map('n', '<Leader>e', '<cmd>HopWord<CR>')

---- git-blame

g.gitblame_enabled = 1
g.gitblame_date_format = '%r'
g.gitblame_message_templete = '<author>・<date>・<summary>'

---- telescope

local telescopeStatus, telescope = pcall(require, "telescope")
if (not telescopeStatus) then return end

local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          ["<C-w>"] = function() cmd('normal vbd') end,
        },
        ["n"] = {
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            cmd('startinsert')
          end
        },
      },
    },
  },
}
telescope.load_extension("file_browser")

------ keymaps

vim.keymap.set('n', ';f',
  function()
    builtin.find_files({
      no_ignore = false,
      hidden = true
    })
  end)
vim.keymap.set('n', ';r', function()
  builtin.live_grep()
end)
vim.keymap.set('n', '\\\\', function()
  builtin.buffers()
end)
vim.keymap.set('n', ';t', function()
  builtin.help_tags()
end)
vim.keymap.set('n', ';;', function()
  builtin.resume()
end)
vim.keymap.set('n', ';e', function()
  builtin.diagnostics()
end)
vim.keymap.set("n", "sf", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 }
  })
end)

---- autotag

local autotagStatus, autotag = pcall(require, "nvim-ts-autotag")
if (not autotagStatus) then return end

autotag.setup({})

---- autopair

local autopairStatus, autopairs = pcall(require, "nvim-autopairs")
if (not autopairStatus) then return end

autopairs.setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

---- nvim-tree-sitter

local treesitterStatus, treesitter = pcall(require, "nvim-treesitter.configs")
if (not treesitterStatus) then return end

treesitter.setup({
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "c",
    "rust",
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "css",
    "html",
    "lua"
  },
  autotag = {
    enable = true,
  },
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

---- builtin LSP

local on_attach = function(client, bufnr)

  -- disable formater
  -- client.resolved_capabilities.document_formatting = false

  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
end

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
  function (server_name)
    local opt = {
      on_attach = on_attach,
      capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    }
    require("lspconfig")[server_name].setup(opt)
  end,
}

------ cmp


opt.completeopt = "menu,menuone,noselect"

local cmp = require"cmp"
cmp.setup({
  snippet = {
    expand = function(args)
      fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
    ["<C-j>"] = cmp.mapping.scroll_docs(4),
    ["<C-f>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }, {
    { name = "buffer" },
  })
})

------ saga

local lspsaga = require 'lspsaga'
lspsaga.setup {
  debug = false,
  use_saga_diagnostic_sign = true,
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>",
  },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  rename_output_qflist = {
    enable = false,
    auto_open_qflist = false,
  },
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  diagnostic_message_format = "%m %c",
  highlight_prefix = false,
}

-------- key

map("n", "gr", "<cmd>Lspsaga rename<cr>", {noremap = true})
map("n", "gx", "<cmd>Lspsaga code_action<cr>", {noremap = true})
map("x", "gx", ":<c-u>Lspsaga range_code_action<cr>", {noremap = true})
map("n", "K",  "<cmd>Lspsaga hover_doc<cr>", {noremap = true})
map("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", {noremap = true})
map("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", {noremap = true})
map("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {noremap = true})
map("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>")
map("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>")

------ fidget

local fisgetStatus, fidget = pcall(require, "fidget")
if (not fisgetStatus) then return end

fidget.setup()

-- colorscheme
cmd 'colorscheme gruvbox'
opt.background = 'dark'
cmd 'let g:gruvbox_contrast_dark = "hard"'
vim.api.nvim_set_hl(0, 'Normal', { ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'NonText', { ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'SpecialKey', { ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'LineNr', { ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'SignColumn', { ctermbg = 'NONE' })
