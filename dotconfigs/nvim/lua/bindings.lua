local utils = require("utils")

local M = {}

-- Constants
local CTRL_JUMP_VERTICAL_LENGTH = 5

function M.bind()
    ---- Navigation
    ---------------------------------------------------------------
    --Telescope
    vim.keymap.set({ "n", "i" }, "<C-S-n>", utils.telescope_find_files, { desc = 'Telescope find files' })
    vim.keymap.set({ "n", "i" }, "<C-S-f>", utils.telescope_find_all, { desc = 'Telescope live grep' })
    vim.keymap.set({ "n", "i" }, "<C-h>", utils.telescope_live_help, { desc = 'Telescope help tags' })
    vim.keymap.set({ "n", "i" }, "<C-S-c>", utils.telescope_find_files_in_config, { desc = 'Find Neovim config files' })
    vim.keymap.set({ "n", "i" }, "<C-S-g>", utils.telescope_find_all_in_config, { desc = 'Grep Neovim config' })
    -- Tabs
    vim.keymap.set({ "n", "i" }, "<M-Left>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
    vim.keymap.set({ "n", "i" }, "<M-Right>", "<cmd>bnext<CR>", { desc = "Next buffer" })

    --Selection
    --  normal mode (pass to insert first, so that when leaving we are there)
    --   that's also useful for other mappings, since we assume leaving visual mode is always insert
    vim.keymap.set("n", "<S-Up>", "i<C-O>v<Up>")
    vim.keymap.set("n", "<S-Down>", "i<C-O>v<Down>")
    vim.keymap.set("n", "<S-Left>", "i<C-O>v<Left>")
    vim.keymap.set("n", "<S-Right>", "i<C-O>v<Right>")
    vim.keymap.set("n", "<C-S-Left>", "i<C-O>vb")
    vim.keymap.set("n", "<C-S-Right>", "i<C-O>ve")
    --  insert mode
    --  vim.keymap.set("i", "<S-Left>", utils.insert_mode_shift_left_select) -- shift select at the end of the line misses the last character
    --  vim.keymap.set("i", "<C-S-Left>", utils.insert_mode_ctrl_shift_left_select)
    vim.keymap.set("i", "<S-Up>", "<C-O>v<Up>")
    vim.keymap.set("i", "<S-Down>", "<C-O>v<Down>")
    vim.keymap.set("i", "<S-Left>", "<C-O>v<Left>")
    vim.keymap.set("i", "<S-Right>", "<C-O>v<Right>")
    vim.keymap.set("i", "<C-S-Left>", "<C-O>vb")
    vim.keymap.set("i", "<C-S-Right>", "<C-O>ve")
    --  visual mode
    vim.keymap.set("v", "<S-Up>", "k")
    vim.keymap.set("v", "<S-Down>", "j")
    vim.keymap.set("v", "<S-Left>", "h")
    vim.keymap.set("v", "<S-Right>", "l")
    vim.keymap.set("v", "<C-S-Right>", "e")
    vim.keymap.set("v", "<C-S-Left>", "b")
    vim.keymap.set("v", "<C-Right>", "e")
    vim.keymap.set("v", "<C-Left>", "b")
    vim.keymap.set("v", "<BS>", '"_di', { silent = true })
    vim.keymap.set("v", "<Del>", '"_di', { silent = true })

    -- Executions
    vim.keymap.set({ "i", "n" }, "<C-S-r>", "<cmd>source %<CR>")

    -- Jumps
    vim.keymap.set("n", "<C-Left>", "i<C-Left>", { noremap = false, silent = true })
    vim.keymap.set("n", "<C-Right>", "i<C-Right>", { noremap = false, silent = true })
    vim.keymap.set("i", "<C-a>", utils.jump_to_start, { noremap = true, silent = true })
    vim.keymap.set("i", "<C-e>", utils.jump_to_end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-e>", utils.jumpt_to_end_into_insert, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-a>", utils.jumpt_to_start_into_insert, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-S-o>", "<C-i>", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-M-Left>", "<C-o>", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-M-Right>", "<C-i>", { noremap = true, silent = true })
    vim.keymap.set({ "n", "i", "v" }, "<C-Up>", function()
        utils.jump_x_up(CTRL_JUMP_VERTICAL_LENGTH)
    end)
    vim.keymap.set({ "n", "i", "v" }, "<C-Down>", function()
        utils.jump_x_down(CTRL_JUMP_VERTICAL_LENGTH)
    end)
    vim.keymap.set("i", "<Left>", utils.move_left_across_lines, { noremap = true, silent = true })
    vim.keymap.set("i", "<Right>", utils.move_right_across_lines, { noremap = true, silent = true })

    -- Find
    vim.keymap.set({ "n", "i" }, "<C-f>", utils.find, { noremap = true, silent = true, desc = "Find" })
    vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- no highlighting

    ---- Manipulations
    -------------------------------------------------------------------
    -- Wrap selection
    for _, pair in ipairs({
        { '"', '"' },
        { "'", "'" },
        { "(", ")" },
        { "[", "]" },
        { "{", "}" }
    }) do
        local wrapSelectionCommand = '<Esc>`>i' .. pair[2] .. '<Esc>`<i' .. pair[1]
        vim.keymap.set("v", pair[1], wrapSelectionCommand .. "<Esc>`>li", { desc = "Wrap selection" })
    end
    --    vim.keymap.set("v", '"', '<Esc>`>i"<Esc>`<i"', { desc = "Wrap selection in quotes" })
    -- Reverse tab
    vim.keymap.set("n", "<S-Tab>", "<<i")
    vim.keymap.set("i", "<S-Tab>", "<C-D>")
    vim.keymap.set("v", "<S-Tab>", "<i")
    -- Move lines
    vim.keymap.set("n", "<C-S-Up>", ":m .-2<CR>==")
    vim.keymap.set("n", "<C-S-Down>", ":m .+1<CR>==")
    vim.keymap.set("v", "<C-S-Up>", ":m '<-2<CR>gv=gv")
    vim.keymap.set("v", "<C-S-Down>", ":m '>+1<CR>gv=gv")
    vim.keymap.set("i", "<C-S-Up>", "<C-O>:m .-2<CR>")
    vim.keymap.set("i", "<C-S-Down>", "<C-O>:m .+1<CR>")
    -- Duplicate
    vim.keymap.set("n", "<C-d>", ":t.<CR>", { noremap = true, silent = true })
    vim.keymap.set("v", "<C-d>", '"+y`>"+p`]', { noremap = true, silent = true })
    vim.keymap.set("i", "<C-d>", "<C-O>:t.<CR>", { noremap = true, silent = true })
    -- Comment
    vim.keymap.set({ "i", "n" }, "<C-S-7>", utils.comment_out_current_line, { noremap = true, silent = true })
    -- Format current buffer
    vim.keymap.set({ "n", "v", "i" }, "<C-M-l>", vim.lsp.buf.format, { desc = "Format" })

    ---- Settings
    -----------------------------------------------------------------

    -- Other Functionalities
    -----------------------------------------------------------
    -- Ctrl+Shift+R = Reload configuration

    -- Comeback to insert
    local pairs = { "{", "}", "[", "]", "(", ")", "<", ">", "!", "#", "-", ",", ";", "'" }
    for _, char in ipairs(pairs) do
        vim.keymap.set("n", char, "i" .. char)
    end
    vim.keymap.set("n", "<CR>", "i<CR>")
    vim.keymap.set("n", "<BS>", "i<BS>")

    vim.keymap.set("i", "<C-s>", function()
        utils.save()
    end, { silent = true })

    vim.keymap.set("i", "<C-t>", function()
        utils.select_all()
    end, { silent = true })

    vim.keymap.set("i", "<C-z>", "<C-o>u", { silent = true })
    vim.keymap.set("i", "<C-S-z>", "<C-o><C-r>", { silent = true })
    vim.keymap.set("i", "<C-v>", "<C-r>+", { silent = true })
    vim.keymap.set("i", "<C-c>", "<C-o>yy", { silent = true })

    -- rename current file
    vim.keymap.set({ "n", "i" }, "<S-F2>", ":file ", { silent = false })

    -- Ctrl+Shift+Enter = terminal
    vim.keymap.set({ "n", "i" }, "<C-S-CR>", "<Esc>:split | terminal<CR>", { silent = true })


    vim.keymap.set({ "n", "i", "v" }, "<C-w>", utils.quit_if_saved, { silent = true })

    -----------------------------------------------------------
    -- NORMAL MODE
    -----------------------------------------------------------

    -- n/N is out, as it's used for find
    -- gg/G is out, as it's used for travelling to end and begining of file
    -- i is out, for insert mode
    -- v is out, for visual mode
    -- _ is out, for console
    --    local chars = "abcdefmopqrstuwxyzABCDEFHIJKLMOPQRSTUVWXYZ0123456789~!@#$%^&*()-_=+[{]}\\|;',.? "
    --    for c in chars:gmatch(".") do
    --        vim.keymap.set("n", c, "i" .. c, { noremap = true })
    --    end
    vim.keymap.set("n", "<C-s>", utils.save, { silent = true })
    vim.keymap.set("n", "<C-t>", utils.select_all, { silent = true })
    vim.keymap.set("n", "<C-c>", '"+yy', { silent = true })
    vim.keymap.set({ "n", "i" }, "<C-x>", '<Esc>ddi', { silent = true })
    vim.keymap.set("n", "<C-v>", '"+p`]l', { silent = true })
    vim.keymap.set("n", "<C-z>", "u", { silent = true })
    vim.keymap.set("n", "<C-S-z>", "<C-r>", { silent = true })
    vim.keymap.set("n", "<C-q>", utils.save_and_exit, { silent = true })

    vim.keymap.set("v", "<C-c>", '"+y`>', { silent = true })
    vim.keymap.set("v", "<C-x>", '"+d', { silent = true })
    vim.keymap.set("v", "<C-v>", '"+p', { silent = true })
    vim.keymap.set("v", "<C-z>", function()
        vim.cmd("undo")
    end, { silent = true })
    vim.keymap.set("v", "<C-S-z>", function()
        vim.cmd("redo")
    end, { silent = true })
    vim.keymap.set("v", "<C-s>", utils.save, { silent = true })

    -- Indentation
    -----------------------------------------------------------
    -- Keep selection after indenting
    vim.keymap.set("v", "<", "<gv", { silent = true })
    vim.keymap.set("v", ">", ">gv", { silent = true })

    -- Delete / Backspace
    -----------------------------------------------------------
    vim.keymap.set("n", "<C-BS>", "i<C-w>", { silent = true })
    vim.keymap.set("i", "<C-BS>", "<C-w>", { silent = true })
    vim.keymap.set("i", "<C-Del>", "<C-o>dw", { silent = true })
end

return M
