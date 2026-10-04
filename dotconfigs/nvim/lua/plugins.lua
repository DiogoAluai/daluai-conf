return {
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = vim.uv.getuid() == 0 and "16color" or "horizon",
                    component_separators = { left = '|', right = '|' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    always_show_tabline = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                        refresh_time = 16, -- ~60fps
                        events = {
                            'WinEnter',
                            'BufEnter',
                            'BufWritePost',
                            'SessionLoadPost',
                            'FileChangedShellPost',
                            'VimResized',
                            'Filetype',
                            'CursorMoved',
                            'CursorMovedI',
                            'ModeChanged',
                        },
                    }
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch' },
                    lualine_c = {},
                    lualine_x = { 'diagnostics' }, -- 'fileformat' (icon), 'filetype' (file suffix), 'location' (rows and cols)
                    lualine_y = { 'encoding', 'progress' },
                    lualine_z = { 'filename' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
            -- Line wrapping for markdown files
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    vim.opt_local.wrap = true -- Enable line wrapping
                    --         vim.opt_local.linebreak = true   -- Break lines at word boundaries
                    --         vim.opt_local.textwidth = 80     -- Set text width for auto-wrapping
                    --      Screen navigation
                    vim.keymap.set("n", "<Down>", "gj", { buffer = true })
                    vim.keymap.set("i", "<Down>", "<C-o>gj", { buffer = true })
                    vim.keymap.set("n", "<Up>", "gk", { buffer = true })
                    vim.keymap.set("i", "<Up>", "<C-o>gk", { buffer = true })
                end,
            })
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        enabled = true,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd.colorscheme(vim.uv.getuid() == 0 and "tokyonight-night" or "tokyonight-storm")
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "diff",
                    "html",
                    "javascript",
                    "java",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "xml",
                    "yaml",
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end
                }
            })
        end
    },
    {
        -- :help lspconfig-all
        "neovim/nvim-lspconfig",
        enabled = true,
        config = function()
            vim.lsp.config('lua_ls', {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath('config')
                            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                        then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most
                            -- likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                            -- Tell the language server how to find Lua modules same way as Neovim
                            -- (see `:h lua-module-load`)
                            path = {
                                'lua/?.lua',
                                'lua/?/init.lua',
                            },
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                                -- For LSP Settings Type Annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
                                vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
                            },
                            -- Or pull in all of 'runtimepath'.
                            -- NOTE: this is a lot slower and will cause issues when working on
                            -- your own configuration.
                            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                            -- library = vim.api.nvim_get_runtime_file('', true),
                        },
                    })
                end,
                settings = {
                    Lua = {},
                },
            })
            vim.lsp.config("ruff", {
                init_options = {
                    settings = {
                        logLevel = 'info', -- info is default
                    },
                },
            })
            vim.lsp.config("basedpyright", {
                -- suggested by Ruff, adapted for basedpyright (https://docs.basedpyright.com/latest/configuration/language-server-settings/)
                settings = {
                    basedpyright = {
                        -- Using Ruff's import organizer
                        disableOrganizeImports = true,
                        typeCheckingMode = "recommended",
                        diagnosticSeverityOverrides = {
                            -- Covered by Ruff's default F rules:
                            -- https://docs.basedpyright.com/latest/configuration/config-files/
                            --                            reportUnusedImport = "none",              -- F401
                            --                            reportUnusedVariable = "none",            -- F841
                            --                            reportDuplicateImport = "none",           -- F811
                            --                            reportWildcardImportFromLibrary = "none", -- F403/F405
                            --                            reportUndefinedVariable = "none",         -- F821
                            --                            reportAssertAlwaysTrue = "none",  -- F631
                            --                            reportUnsupportedDunderAll = "none", -- F822 (partial)

                            -- Only if you've enabled the matching Ruff rules:
                            -- reportInvalidStringEscapeSequence = "none", -- W605
                            -- reportUnusedExpression = "none",            -- B018
                            -- reportSelfClsParameterName = "none",        -- N804/N805
                            -- reportImplicitStringConcatenation = "none", -- ISC
                            -- reportUnusedParameter = "none",             -- ARG
                            -- reportPrivateUsage = "none",                -- SLF001
                        },
                    },
                },

            })
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client == nil then
                        return
                    end
                    if client.name == 'ruff' then
                        -- Disable hover in favor of basedpyright
                        client.server_capabilities.hoverProvider = false
                    end
                end,
                desc = 'LSP: Disable hover capability from Ruff',
            })
            vim.lsp.config("bashls", {
                cmd = {
                    "/home/daluai/.nvm/versions/node/v22.16.0/bin/node",
                    "/home/daluai/.nvm/versions/node/v22.16.0/bin/bash-language-server",
                    "start",
                }
            })
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("ruff")
            vim.lsp.enable("basedpyright")
            vim.lsp.enable("bashls")
        end
    },

}
