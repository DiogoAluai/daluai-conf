return {
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup({
                signs = false,     -- show icons in the signs column
                sign_priority = 8, -- sign priority
                -- keywords recognized as 'todo' comments
                keywords = {
                    FIX = {
                        icon = " ", -- icon used for the sign, and in search results
                        color = "error", -- can be a hex color, or a named color (see below)
                        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                        -- signs = false, -- configure signs for some keywords individually
                    },
                    TODO = { icon = " ", color = "warning", alt = { "todo", "Todo" } },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
                },
                gui_style = {
                    fg = "NONE",       -- The gui style to use for the fg highlight group.
                    bg = "BOLD",       -- The gui style to use for the bg highlight group.
                },
                merge_keywords = true, -- when true, custom keywords will be merged with the defaults
                -- highlighting of the line containing the 'todo' comment
                -- * before: highlights before the keyword (typically comment characters)
                -- * keyword: highlights of the keyword
                -- * after: highlights after the keyword (todo text)
                highlight = {
                    multiline = false,           -- enable multine todo comments
                    multiline_pattern = "^.",    -- lua pattern to match the next multiline from the start of the matched keyword
                    multiline_context = 10,      -- extra lines that will be re-evaluated when changing a line
                    before = "",                 -- "fg" or "bg" or empty
                    keyword = "bg",              -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                    after = "fg",                -- "fg" or "bg" or empty
                    pattern = [[.*<(KEYWORDS):?]], -- pattern or table of patterns, used for highlighting (vim regex). Time sinker, this regex. Wish I could make 'todo' not highlighting
                    comments_only = true,        -- uses treesitter to match keywords in comments only
                    max_line_len = 300,          -- ignore lines longer than this
                    exclude = {},                -- list of file types to exclude highlighting
           },
                -- list of named colors where we try to extract the guifg from the
                -- list of highlight groups or use the hex color if hl not found as a fallback
                colors = {
                    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                    info = { "DiagnosticInfo", "#2563EB" },
                    hint = { "DiagnosticHint", "#10B981" },
                    default = { "Identifier", "#7C3AED" },
                    test = { "Identifier", "#FF00FF" }
                },
            })
        end
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
        config = function()
            require("oil").setup({
                -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
                -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
                default_file_explorer = true,
                -- Id is automatically added at the beginning, and name at the end
                -- See :help oil-columns
                columns = {
                    "icon",
                    -- "permissions",
                    -- "size", -- todo: make size togleable
                    -- "mtime",
                },
                -- Buffer-local options to use for oil buffers
                buf_options = {
                    buflisted = false,
                    bufhidden = "hide",
                },
                -- Window-local options to use for oil buffers
                win_options = {
                    wrap = false,
                    signcolumn = "no",
                    number = false,
                    relativenumber = false,
                    cursorcolumn = false,
                    foldcolumn = "0",
                    spell = false,
                    list = false,
                    conceallevel = 3,
                    concealcursor = "nvic",
                },
                -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
                delete_to_trash = false,
                -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
                skip_confirm_for_simple_edits = false,
                -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
                -- (:help prompt_save_on_select_new_entry)
                prompt_save_on_select_new_entry = true,
                -- Oil will automatically delete hidden buffers after this delay
                -- You can set the delay to false to disable cleanup entirely
                -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
                cleanup_delay_ms = 2000,
                lsp_file_methods = {
                    -- Enable or disable LSP file operations
                    enabled = true,
                    -- Time to wait for LSP file operations to complete before skipping
                    timeout_ms = 1000,
                    -- Set to true to autosave buffers that are updated with LSP willRenameFiles
                    -- Set to "unmodified" to only save unmodified buffers
                    autosave_changes = false,
                },
                -- Constrain the cursor to the editable parts of the oil buffer
                -- Set to `false` to disable, or "name" to keep it on the file names
                constrain_cursor = "editable",
                -- Set to true to watch the filesystem for changes and reload oil
                watch_for_changes = false,
                -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
                -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
                -- Additionally, if it is a string that matches "actions.<name>",
                -- it will use the mapping at require("oil.actions").<name>
                -- Set to `false` to remove a keymap
                -- See :help oil-actions for a list of all available actions
                keymaps = {
                    ["g?"] = { "actions.show_help", mode = "n" },
                    ["<CR>"] = "actions.select",
                    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
                    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
                    ["<C-t>"] = { "actions.select", opts = { tab = true } },
                    ["<C-p>"] = "actions.preview",
                    ["<C-c>"] = { "actions.close", mode = "n" },
                    ["<C-l>"] = "actions.refresh",
                    ["-"] = { "actions.parent", mode = "n" },
                    ["_"] = { "actions.open_cwd", mode = "n" },
                    ["`"] = { "actions.cd", mode = "n" },
                    ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                    ["gs"] = { "actions.change_sort", mode = "n" },
                    ["<C-CR>"] = "actions.open_external",
                    ["g."] = { "actions.toggle_hidden", mode = "n" },
                    ["g\\"] = { "actions.toggle_trash", mode = "n" },
                },
                -- Set to false to disable all of the above keymaps
                use_default_keymaps = true,
                view_options = {
                    -- Show files and directories that start with "."
                    show_hidden = false,
                    -- This function defines what is considered a "hidden" file
                    is_hidden_file = function(name, bufnr)
                        local m = name:match("^%.")
                        return m ~= nil
                    end,
                    -- This function defines what will never be shown, even when `show_hidden` is set
                    is_always_hidden = function(name, bufnr)
                        return false
                    end,
                    -- Sort file names with numbers in a more intuitive order for humans.
                    -- Can be "fast", true, or false. "fast" will turn it off for large directories.
                    natural_order = "fast",
                    -- Sort file and directory names case insensitive
                    case_insensitive = false,
                    sort = {
                        -- sort order can be "asc" or "desc"
                        -- see :help oil-columns to see which columns are sortable
                        { "type", "asc" },
                        { "name", "asc" },
                    },
                    -- Customize the highlight group for the file name
                    highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
                        return nil
                    end,
                },
                -- Extra arguments to pass to SCP when moving/copying files over SSH
                extra_scp_args = {},
                -- Extra arguments to pass to aws s3 when creating/deleting/moving/copying files using aws s3
                extra_s3_args = {},
                -- EXPERIMENTAL support for performing file operations with git
                git = {
                    -- Return true to automatically git add/mv/rm files
                    add = function(path)
                        return false
                    end,
                    mv = function(src_path, dest_path)
                        return false
                    end,
                    rm = function(path)
                        return false
                    end,
                },
                -- Configuration for the floating window in oil.open_float
                float = {
                    -- Padding around the floating window
                    padding = 2,
                    -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                    max_width = 0,
                    max_height = 0,
                    border = nil,
                    win_options = {
                        winblend = 0,
                    },
                    -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
                    get_win_title = nil,
                    -- preview_split: Split direction: "auto", "left", "right", "above", "below".
                    preview_split = "auto",
                    -- This is the config that will be passed to nvim_open_win.
                    -- Change values here to customize the layout
                    override = function(conf)
                        return conf
                    end,
                },
                -- Configuration for the file preview window
                preview_win = {
                    -- Whether the preview window is automatically updated when the cursor is moved
                    update_on_cursor_moved = true,
                    -- How to open the preview window "load"|"scratch"|"fast_scratch"
                    preview_method = "fast_scratch",
                    -- A function that returns true to disable preview on a file e.g. to avoid lag
                    disable_preview = function(filename)
                        return false
                    end,
                    -- Window-local options to use for preview window buffers
                    win_options = {},
                },
                -- Configuration for the floating action confirmation window
                confirmation = {
                    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                    -- min_width and max_width can be a single value or a list of mixed integer/float types.
                    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
                    max_width = 0.9,
                    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
                    min_width = { 40, 0.4 },
                    -- optionally define an integer/float for the exact width of the preview window
                    width = nil,
                    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                    -- min_height and max_height can be a single value or a list of mixed integer/float types.
                    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
                    max_height = 0.9,
                    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
                    min_height = { 5, 0.1 },
                    -- optionally define an integer/float for the exact height of the preview window
                    height = nil,
                    border = nil,
                    win_options = {
                        winblend = 0,
                    },
                },
                -- Configuration for the floating progress window
                progress = {
                    max_width = 0.9,
                    min_width = { 40, 0.4 },
                    width = nil,
                    max_height = { 10, 0.9 },
                    min_height = { 5, 0.1 },
                    height = nil,
                    border = nil,
                    minimized_border = "none",
                    win_options = {
                        winblend = 0,
                    },
                },
                -- Configuration for the floating SSH window
                ssh = {
                    border = nil,
                },
                -- Configuration for the floating keymaps help window
                keymaps_help = {
                    border = nil,
                },
            })
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
