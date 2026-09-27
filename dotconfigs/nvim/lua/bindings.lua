
local utils = require("utils")

local M = { }

-- Constants
local CTRL_JUMP_VERTICAL_LENGTH = 5

function M.bind()

    ---- Navigation
    ---------------------------------------------------------------
    --Telescope
    vim.keymap.set({"n","i"}, "<C-S-n>", utils.telescope_find_files, { desc = 'Telescope find files' })
    vim.keymap.set({"n","i"}, "<C-S-f>", utils.telescope_find_all, { desc = 'Telescope live grep' })
    vim.keymap.set({"n","i"}, "<C-h>", utils.telescope_live_help, { desc = 'Telescope help tags' })
    --Selection
    vim.keymap.set({"n", "v"}, "<S-Up>", "k")
    vim.keymap.set({"n", "v"}, "<S-Down>", "j")
    vim.keymap.set("i", "<S-Left>", "<C-O>v<Left>")
    vim.keymap.set("i", "<S-Right>", "<C-O>v<Right>")
    vim.keymap.set("i", "<C-S-Left>", "<C-O>vb")
    vim.keymap.set("i", "<C-S-Right>", "<C-O>ve")
    vim.keymap.set("i", "<S-Up>", "<C-O>v<Up>")
    vim.keymap.set("i", "<S-Down>", "<C-O>v<Down>")
    vim.keymap.set("i", "<C-S-Up>", "<C-O>v<Up>")     -- too lazy to make it jump instantly
    vim.keymap.set("i", "<C-S-Down>", "<C-O>v<Down>") -- too lazy to make it jump instantly
    vim.keymap.set("v", "<C-Right>", "e")
    vim.keymap.set("v", "<C-Left>", "b")
    vim.keymap.set("v", "<C-S-Right>", "e")
    vim.keymap.set("v", "<C-S-Left>", "b")
    vim.keymap.set("v", "<BS>", '"_d i', { silent = true })
    vim.keymap.set("v", "<Del>", '"_d i', { silent = true })

    -- Executions
    vim.keymap.set({"i", "n"}, "<C-S-r>", "<cmd>source %<CR>")

    -- Jumps
    vim.keymap.set("n", "<C-Left>", "i<C-Left>", { noremap = false, silent = true })
    vim.keymap.set("n", "<C-Right>", "i<C-Right>", { noremap = false, silent = true })
    vim.keymap.set("i", "<C-a>", utils.jump_to_start, { noremap = true, silent = true })
    vim.keymap.set("i", "<C-e>", utils.jump_to_end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-e>", utils.jumpt_to_end_into_insert, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-a>", utils.jumpt_to_start_into_insert, { noremap = true, silent = true })
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
    -- TODO: don't yank, you're poluting the clipboard!
    vim.keymap.set("n", "<C-d>", "yyp", { noremap = true, silent = true })
    vim.keymap.set("v", "<C-d>", "yP", { noremap = true, silent = true })
    vim.keymap.set("i", "<C-d>", "<C-o>yy<C-o>p", { noremap = true, silent = true })
    -- Comment
    vim.keymap.set({ "i", "n" }, "<C-S-7>", utils.comment_out_current_line, { noremap = true, silent = true })

    ---- Settings
    -----------------------------------------------------------------

    -- Other Functionalities
    -----------------------------------------------------------
    -- Ctrl+Shift+R = Reload configuration
    vim.keymap.set({"n", "i"}, "<C-S-r>", function()
        vim.cmd("source ~/.config/nvim/init.lua")
    end, { silent = true })

    -- Comeback to insert
    local pairs = { "{", "}", "[", "]", "(", ")", "<", ">" }

    for _, char in ipairs(pairs) do
        vim.keymap.set("n", char, "i" .. char)
    end

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

    -- F2 = rename current file
    vim.keymap.set("n", "<F2>", ":file ", { silent = false })

    -- F4 = terminal
    vim.keymap.set("n", "<F4>", ":split | terminal<CR>", { silent = true })


    vim.keymap.set({"n", "i", "v"}, "<C-w>", utils.quit_if_saved, { silent = true })

    -----------------------------------------------------------
    -- NORMAL MODE
    -----------------------------------------------------------
    vim.keymap.set("n", "<C-s>", utils.save, { silent = true })
    vim.keymap.set("n", "<C-t>", utils.select_all, { silent = true })
    vim.keymap.set("n", "<C-c>", '"+yy', { silent = true })
    vim.keymap.set({"n", "i"}, "<C-x>", '<Esc>ddi', { silent = true })
    vim.keymap.set("n", "<C-v>", '"+p', { silent = true })
    vim.keymap.set("n", "<C-z>", "u", { silent = true })
    vim.keymap.set("n", "<C-S-z>", "<C-r>", { silent = true })
    vim.keymap.set("n", "<C-q>", utils.save_and_exit, { silent = true })

    vim.keymap.set("v", "<C-c>", '"+y', { silent = true })
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
    vim.keymap.set("i", "<C-BS>", "<C-w>", { silent = true })
    vim.keymap.set("i", "<C-Del>", "<C-o>dw", { silent = true })
end

return M
