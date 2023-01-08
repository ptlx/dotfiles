local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({function(use)
    use 'wbthomason/packer.nvim'
    use {
        'svrana/neosolarized.nvim' ,
        requires = { 'tjdevries/colorbuddy.nvim' },
        config = function()
            require'neosolarized'.setup {
                comment_italics = true,
            }
            local cb = require('colorbuddy.init')
            local Color = cb.Color
            local colors = cb.colors
            local Group = cb.Group
            local groups = cb.groups
            local styles = cb.styles

            Color.new('black', '#000000')
            Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
            Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
            Group.new('Visual', colors.none, colors.base03, styles.reverse)

            local cError = groups.Error.fg
            local cInfo = groups.Information.fg
            local cWarn = groups.Warning.fg
            local cHint = groups.Hint.fg

            Group.new('DiagnosticVirtualTextError', cError, cError:dark():dark():dark():dark(), styles.NONE)
            Group.new('DiagnosticVirtualTextInfo', cInfo, cInfo:dark():dark():dark(), styles.NONE)
            Group.new('DiagnosticVirtualTextWarn', cWarn, cWarn:dark():dark():dark(), styles.NONE)
            Group.new('DiagnosticVirtualTextHint', cHint, cHint:dark():dark():dark(), styles.NONE)
            Group.new('DiagnosticUnderlineError', colors.none, colors.none, styles.undercurl, cError)
            Group.new('DiagnosticUnderlineWarn', colors.none, colors.none, styles.undercurl, cWarn)
            Group.new('DiagnosticUnderlineInfo', colors.none, colors.none, styles.undercurl, cInfo)
            Group.new('DiagnosticUnderlineHint', colors.none, colors.none, styles.undercurl, cHint)
        end,
    }-- color scheme
    use {
        'norcalli/nvim-colorizer.lua',
        event = { 'FocusLost', 'CursorHold' },
        config = function()
            require'colorizer'.setup {}
        end,
    }
-- show file name
    use {
        'petertriho/nvim-scrollbar',
        event = {
            'BufWinEnter',
            'CmdwinLeave',
            'TabEnter',
            'TermEnter',
            'TextChanged',
            'VimResized',
            'WinEnter',
            'WinScrolled',
        },
        config = function()
            require'scrollbar'.setup {}
        end,
    }--show scroll bar
    use {
        'phaazon/hop.nvim',
        branch = 'v2',
        module = { 'hop' },
        setup = function()
            local directions = require('hop.hint').HintDirection
            vim.keymap.set({ 'n', 'v' }, 'f', function()
                require('hop').hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
            end, { remap = true })
            vim.keymap.set({ 'n', 'v' }, 'F', function()
                require('hop').hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
            end, { remap = true })
            vim.keymap.set({ 'n', 'v' }, 't', function()
                require('hop').hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
            end, { remap = true })
            vim.keymap.set({ 'n', 'v' }, 'T', function()
                require('hop').hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
            end, { remap = true })
            vim.keymap.set({ 'n', 'v' }, '<Leader>w', function()
                require('hop').hint_words()
            end, { remap = false })
            vim.keymap.set({ 'n', 'v' }, '<Leader>a', function()
                require('hop').hint_anywhere()
            end, { remap = false })
            vim.keymap.set({ 'n', 'v' }, '<Leader>l', function()
                require('hop').hint_lines()
            end, { remap = false })
        end,
        config = function()
            require'hop'.setup {}
        end,
    }-- easy motion
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require'gitsigns'.setup {}
        end,
    }-- git
    use {
        'f-person/git-blame.nvim',
        event = { 'FocusLost', 'CursorHold' },
        config = function()
            vim.g.gitblame_enabled = 1
            vim.g.gitblame_date_format = '%r'
            vim.g.gitblame_message_templete = '<author>・<date>・<summary>'
        end,
    }-- git blame
    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require'nvim-autopairs'.setup {
                disable_filetype = { 'TelescopePropmt', 'vim' },
            }
        end,
    }-- auto pairs
    use {
        'windwp/nvim-ts-autotag',
        event = 'InsertEnter',
        config = function()
	end,
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require'nvim-treesitter.configs'.setup {
                autoinstall = true,
                highlight = {
                    enable = true,
                    disable = {},
                },
                indent = {
                    enable = true,
                    disable = {},
                },
                ensure_installed = {
                    'bash',
                    'c',
                    'cmake',
                    'cpp',
                    'css',
                    'dockerfile',
                    'fish',
                    'go',
                    'html',
                    'java',
                    'javascript',
                    'json',
                    'lua',
                    'markdown',
                    'python',
                    'rust',
                    'scala',
                    'scss',
                    'toml',
                    'tsx',
                    'typescript',
                    'vim',
                    'yaml',
                },
                autotag = {
                    enable = true,
                },
            }
        end
    }-- treesitter
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = {
            { 'nvim-lua/plenary.nvim', opt = true },
            { 'nvim-telescope/telescope-file-browser.nvim', opt = true },
            { 'kyazdani42/nvim-web-devicons', opt = true },
        },
        wants = { 'plenary.nvim', 'telescope-file-browser.nvim', 'nvim-web-devicons' },
        module = { 'telescope', 'telescope.builtin' },
        setup = function()
            local function telescope_buffer_dir()
                return vim.fn.expand('%:p:h')
            end
            vim.keymap.set('n', ';f',
                function()
                    require('telescope.builtin').find_files({
                        no_ignore = false,
                        hidden = true
                    })
                end)
            vim.keymap.set('n', ';r', function()
                require('telescope.builtin').live_grep()
            end)
            vim.keymap.set('n', '\\\\', function()
                require('telescope.builtin').buffers()
            end)
            vim.keymap.set('n', ';t', function()
                require('telescope.builtin').help_tags()
            end)
            vim.keymap.set('n', ';;', function()
                require('telescope.builtin').resume()
            end)
            vim.keymap.set('n', ';e', function()
                require('telescope.builtin').diagnostics()
            end)
            vim.keymap.set('n', 'sf', function()
                require('telescope').extensions.file_browser.file_browser({
                    path = '%:p:h',
                    cwd = telescope_buffer_dir(),
                    respect_gitignore = false,
                    hidden = true,
                    grouped = true,
                    previewer = false,
                    initial_mode = 'normal',
                    layout_config = { height = 40 }
                })
            end)
            vim.keymap.set('n', 'sn', function()
                require('telescope').extensions.notify.notify()
            end)
        end,
        config = function()
            local actions = require('telescope.actions')
            local fb_actions = require('telescope').extensions.file_browser.actions
            require('telescope').setup {
                defaults = {
                    mappings = {
                        n = {
                            ['q'] = actions.close
                        },
                    },
                },
                extensions = {
                    file_browser = {
                        theme = 'dropdown',
                        hijack_netrw = true,
                        mappings = {
                            ['i'] = {
                                ['<C-w>'] = function() vim.cmd('normal vbd') end,
                            },
                            ['n'] = {
                                ['h'] = fb_actions.goto_parent_dir,
                                ['/'] = function()
                                    vim.cmd('startinsert')
                                end
                            },
                        },
                    },
                },
            }
        end,
    }-- telescope
    use {
        'hrsh7th/nvim-cmp',
        module = { 'cmp' },
        event = { 'InsertEnter' },
        requires = {
            -- TODO どれかsourceが悪さしてる。いらないの消せ
            { 'neovim/nvim-lspconfig', event = { 'InsertEnter'} },
            { 'hrsh7th/cmp-nvim-lsp', event = { 'InsertEnter' } },
            { 'hrsh7th/cmp-buffer', event = { 'InsertEnter' } },
            { 'hrsh7th/cmp-path', event = { 'InsertEnter' } },
            { 'hrsh7th/cmp-cmdline', event = { 'InsertEnter' } },
            { 'hrsh7th/nvim-cmp', event = { 'InsertEnter' } },
            { 'onsails/lspkind.nvim', event = { 'InsertEnter' } },
            { 'hrsh7th/cmp-vsnip', event = { 'InsertEnter' } },
            { 'hrsh7th/vim-vsnip', event = { 'InsertEnter' } },
            -- { 'ray-x/cmp-treesitter', event = { 'InsertEnter' } },
            { 'hrsh7th/cmp-nvim-lua', event = { 'InsertEnter' } },
            -- { 'hrsh7th/cmp-calc', event = { 'InsertEnter' } },
            -- { 'f3fora/cmp-spell', event = { 'InsertEnter' } },
            -- { 'yutkat/cmp-mocword', event = { 'InsertEnter' } },
            -- { 'hrsh7th/cmp-omni', event = { 'InsertEnter' } },
        },
        config = function()
            vim.opt.completeopt = 'menu,menuone,noselect'
            local cmp = require('cmp')
            cmp.setup {
                snippet = {
                    expand = function(args)
                        vim.fn['vsnip#anonymous'](args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-f>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'vsnip' },
                    --{ name = 'treesitter' },
                    --{ name = 'nvim_lua' },
                    --{ name = 'calc' },
                    --{
                    --    name = 'spell',
                    --    option = {
                    --        keep_all_entries = false,
                    --        enable_in_context = function ()
                    --            return true
                    --        end,
                    --    },
                    --},
                    --{ name = 'mocword' },
                    --{ name = 'omni' },
                }),
                formatting = {
                    format = require('lspkind').cmp_format({ with_text = false, maxwidth = 50 })
                },
            }
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                        {
                            name = 'cmdline',
                            option = {
                                ignore_cmds = { 'Man', '!' }
                            }
                        }
                    })
            })
        end,
    }-- cmp
    use { 'onsails/lspkind.nvim' }
    use { 'neovim/nvim-lspconfig' }
    use { 'williamboman/mason.nvim' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use {
        'williamboman/mason-lspconfig.nvim',
        requirements = {
            { 'mfussenegger/nvim-dap', opt = true },
            { 'jose-elias-alvarez/null-ls.nvim', opt = true },
            { 'mfussenegger/nvim-lint', opt = true },
            { 'mhartington/formatter.nvim', opt = true },
            { 'hrsh7th/cmp-nvim-lsp', opt = true },
        },
        wants = {
            'nvim-dap', 'null-ls.nvim', 'nvim-lint', 'formatter.nvim', 'cmp-nvim-lsp'
        },
        config = function()
            local on_attach = function(client, bufnr)
                vim.keymap.set('n', 'gn', function() vim.lsp.buf.references() end)
            end
            require('lspconfig').tsserver.setup {
                on_attach = on_attach,
                filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
                cmd = { 'typescript-language-server', '--stdio' }
            }
            require('mason').setup {}
            require('mason-lspconfig').setup {
                ensure_installed = {}
            }
            require('mason-lspconfig').setup_handlers {
                function (server_name)
                    local masonopt = {
                        on_attach = on_attach,
                        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
                    }
                    require('lspconfig')[server_name].setup(masonopt)
                end,
            }
            vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
            )
        end,
    }
    use {
        'kkharji/lspsaga.nvim',
        branch = 'main',
        setup = function()
            vim.keymap.set('n', 'gd', '<cmd>Lspsaga lsp_finder<CR>', { silent = true })
            vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<cr>', { silent = true })
            vim.keymap.set('n', 'K',  '<cmd>Lspsaga hover_doc<cr>', { silent = true })
            vim.keymap.set('n', 'ge',  '<cmd>Lspsaga show_line_diagnostics<cr>', { silent = true })
            vim.keymap.set('n', 'gj',  '<cmd>Lspsaga diagnostic_jump_next<cr>', { silent = true })
            vim.keymap.set('n', 'gk',  '<cmd>Lspsaga diagnostic_jump_prev<cr>', { silent = true })
            vim.keymap.set('n', 'gx', '<cmd>Lspsaga code_action<cr>', {silent = true})
            vim.keymap.set('x', 'gx', ':<c-u>Lspsaga range_code_action<cr>', {silent = true})
        end,
        config = function()
            local saga = require('lspsaga')
            saga.init_lsp_saga {
                server_filetype_map = {
                    typescript = 'typescript'
                }
            }
            saga.setup {
                debug = false,
                use_saga_diagnostic_sign = true,
                error_sign = '',
                warn_sign = '',
                hint_sign = '',
                infor_sign = '',
                diagnostic_header_icon = '   ',
                code_action_icon = ' ',
                code_action_prompt = {
                    enable = true,
                    sign = true,
                    sign_priority = 40,
                    virtual_text = true,
                },
                finder_definition_icon = '  ',
                finder_reference_icon = '  ',
                max_preview_lines = 10,
                finder_action_keys = {
                    open = 'o',
                    vsplit = 's',
                    split = 'i',
                    quit = 'q',
                    scroll_down = '<C-f>',
                    scroll_up = '<C-b>',
                },
                code_action_keys = {
                    quit = 'q',
                    exec = '<CR>',
                },
                rename_action_keys = {
                    quit = '<C-c>',
                    exec = '<CR>',
                },
                definition_preview_icon = '  ',
                border_style = 'single',
                rename_prompt_prefix = '➤',
                rename_output_qflist = {
                    enable = false,
                    auto_open_qflist = false,
                },
                server_filetype_map = {},
                diagnostic_prefix_format = '%d. ',
                diagnostic_message_format = '%m %c',
                highlight_prefix = false,
            }
        end,
    }-- lsp saga
    use {
        'numToStr/FTerm.nvim',
        module = { 'FTerm' },
        setup = function ()
            vim.keymap.set('n', '<Leader>t', function ()
                require('FTerm').toggle()
            end)
            vim.keymap.set('t', '<Leader>t', function ()
                require('FTerm').toggle()
            end)
            vim.keymap.set('n', '<Leader>b', function ()
                require('FTerm'):new({ ft = 'fterm_btop', cmd = 'btop' }):toggle()
            end)
            vim.keymap.set('n', '<Leader>g', function ()
                require('FTerm'):new({ ft = 'fterm_gitui', cmd = 'gitui' }):toggle()
            end)
        end,
        config = function ()
            require('FTerm').setup {
                border = 'double',
                dimensions = {
                    height = 0.9,
                    width = 0.9,
                },
            }
        end,
    }-- terminal
    use {
        'folke/noice.nvim',
        requires = {
            { 'MunifTanjim/nui.nvim' },
        },
        config = function ()
            require('noice').setup {
                lsp = {
                    override = {
                        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                        ['vim.lsp.util.stylize_markdown'] = true,
                        ['cmp.entry.get_documentation'] = true,
                    },
                },
                cmdline = {
                    format = {
                        cmdline = { icon = ">" },
                        search_down = { icon = "🔍⌄" },
                        search_up = { icon = "🔍⌃" },
                        filter = { icon = "$" },
                        lua = { icon = "☾" },
                        help = { icon = "?" },
                    },
                },
            }
        end
    }-- cmdheight = 0
    use {
        'rust-lang/rust.vim',
        config = function ()
            vim.g.rustfmt_autosave = 1
        end
    }-- rust
    use {
        'sudormrfbin/cheatsheet.nvim' ,
        requires = {
            {'nvim-telescope/telescope.nvim'},
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
        }
    }


    if packer_bootstrap then
        require('packer').sync()
    end
end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
}
)
