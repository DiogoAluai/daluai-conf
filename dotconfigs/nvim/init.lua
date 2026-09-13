
-----------------------------------------------------------
-- CUA-style / non-modal Neovim
-----------------------------------------------------------

require("config.lazy")

---- Constants
-----------------------------------------------------------
local CTRL_JUMP_VERTICAL_LENGTH = 5

---- Utils
-----------------------------------------------------------
local function save()
    vim.cmd("update")
end

local function save_and_exit()
    vim.cmd("update")
    vim.cmd("quit")
end

local function select_all()
    vim.cmd("normal! ggVG")
end


local function execute_str(cmdStr)
     -- Arguments
     --     str: The string containing key codes to convert.
     --     from_part: Expands <lt> and interprets codes as part of a mapping if set to true.
     --     do_lt: Replaces <lt> with < if set to true.
     --     special: Interprets special keys/codes like <CR>, <Esc>, and <C-u>.
     -- "n" means no remaping
      vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes(cmdStr, true, false, true),
              "n", false)
end

local function jump_to_start()
    -- "<C-o> executes something and cames back to insert
    execute_str("<C-o>0")
end

local function jump_to_end()
    execute_str("<C-o>$")
end


local function move_left_across_lines()
    if vim.fn.col(".") == 1 and vim.fn.line(".") > 1 then
        execute_str("<C-o>k") -- up
        jump_to_end()
    else
        vim.cmd("normal! h")
    end
end

local function move_right_across_lines()
    local column = vim.fn.col(".")
    local line = vim.fn.line(".")
    local line_end = vim.fn.col("$")

    if column >= line_end and line < vim.fn.line("$") then
        execute_str("<C-o>j") -- down
        execute_str("<C-o>0") -- start
    elseif column == line_end - 1 and line < vim.fn.line("$") then
        -- in the second to last column, using <C-o>l does not move the caret 
        jump_to_end()
    else
        vim.cmd("normal! l")
    end
end

local function jumpt_to_end_into_insert()
    jump_to_end()
    vim.cmd("startinsert")
end

local function jumpt_to_start_into_insert()
    jump_to_start()
    vim.cmd("startinsert")
end

local function jump_x_up(x)
    vim.cmd("normal! " .. x .. "k")
end


local function jump_x_down(x)
    vim.cmd("normal! " .. x .. "j")
end

local function find()
    vim.api.nvim_echo({ { "Find: ", "ModeMsg" } }, false, {})
    local char = vim.fn.getcharstr()
    execute_str("<Esc>/" .. char)
end



---- Navigation
---------------------------------------------------------------

--Selection
vim.keymap.set({"n", "v"}, "<S-Up>", "k")
vim.keymap.set({"n", "v"}, "<S-Down>", "j")
vim.keymap.set("i", "<S-Left>", "<C-O>v<Left>")
vim.keymap.set("i", "<S-Right>", "<C-O>v<Right>")
vim.keymap.set("i", "<C-S-Left>", "<C-O>vb")
vim.keymap.set("i", "<C-S-Right>", "<C-O>ve")
vim.keymap.set("i", "<S-Up>", "<C-O>V<Up>")
vim.keymap.set("i", "<S-Down>", "<C-O>V<Down>")
vim.keymap.set("i", "<C-S-Up>", "<C-O>V<Up>") -- too lazy to make it jump instantly
vim.keymap.set("i", "<C-S-Down>", "<C-O>V<Down>") -- too lazy to make it jump instantly
vim.keymap.set("v", "<C-Right>", "e")
vim.keymap.set("v", "<C-Left>", "b")
vim.keymap.set("v", "<C-S-Right>", "e")
vim.keymap.set("v", "<C-S-Left>", "b")

-- Executions
vim.keymap.set({"i", "n"}, "<C-S-r>", "<cmd>source %<CR>")

-- Jumps
vim.keymap.set("i", "<C-a>", jump_to_start, { noremap = true, silent = true })
vim.keymap.set("i", "<C-e>", jump_to_end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-e>", jumpt_to_end_into_insert, { noremap = true, silent = true })
vim.keymap.set("n", "<C-a>", jumpt_to_start_into_insert, { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<C-Up>", function()
    jump_x_up(CTRL_JUMP_VERTICAL_LENGTH)
end)
vim.keymap.set({ "n", "i", "v" }, "<C-Down>", function()
    jump_x_down(CTRL_JUMP_VERTICAL_LENGTH)
end)
vim.keymap.set("i", "<Left>", move_left_across_lines, { noremap = true, silent = true })
vim.keymap.set("i", "<Right>", move_right_across_lines, { noremap = true, silent = true })

-- Find
vim.keymap.set({ "n", "i" }, "<C-f>", find, { noremap = true, silent = true, desc = "Find" })

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
vim.keymap.set("n", "<C-d>", "yyp", { silent = true })
vim.keymap.set("v", "<C-d>", "yP", { silent = true })
vim.keymap.set("i", "<C-d>", "<C-o>yyp", { silent = true })


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
    save()
end, { silent = true })

vim.keymap.set("i", "<C-t>", function()
    select_all()
end, { silent = true })

vim.keymap.set("i", "<C-z>", "<C-o>u", { silent = true })
vim.keymap.set("i", "<C-S-z>", "<C-o><C-r>", { silent = true })
vim.keymap.set("i", "<C-v>", "<C-r>+", { silent = true })
vim.keymap.set("i", "<C-c>", "<C-o>yy", { silent = true })

local function quit_if_saved()
    if vim.bo.modified then
        vim.notify("Unsaved changes")
    else
        vim.notify("Quitting")
        vim.cmd("q")
    end
end

-- F2 = rename current file
vim.keymap.set("n", "<F2>", ":file ", { silent = false })

-- F4 = terminal
vim.keymap.set("n", "<F4>", ":split | terminal<CR>", { silent = true })


vim.keymap.set({"n", "i", "v"}, "<C-w>", quit_if_saved, { silent = true })

-----------------------------------------------------------
-- NORMAL MODE
-----------------------------------------------------------
vim.keymap.set("n", "<C-s>", save, { silent = true })
vim.keymap.set("n", "<C-t>", select_all, { silent = true })
vim.keymap.set("n", "<C-c>", '"+yy', { silent = true })
vim.keymap.set({"n", "i"}, "<C-x>", '<Esc>ddi', { silent = true })
vim.keymap.set("n", "<C-v>", '"+p', { silent = true })
vim.keymap.set("n", "<C-z>", "u", { silent = true })
vim.keymap.set("n", "<C-S-z>", "<C-r>", { silent = true })
vim.keymap.set("n", "<C-q>", save_and_exit, { silent = true })

vim.keymap.set("v", "<C-c>", '"+y', { silent = true })
vim.keymap.set("v", "<C-x>", '"+d', { silent = true })
vim.keymap.set("v", "<C-v>", '"+p', { silent = true })
vim.keymap.set("v", "<C-z>", function()
    vim.cmd("undo")
end, { silent = true })
vim.keymap.set("v", "<C-S-z>", function()
    vim.cmd("redo")
end, { silent = true })
vim.keymap.set("v", "<C-s>", save, { silent = true })

-- Indentation
-----------------------------------------------------------
-- Keep selection after indenting.
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- Delete / Backspace
-----------------------------------------------------------
vim.keymap.set("i", "<C-BS>", "<C-w>", { silent = true })
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { silent = true })


-----------------------------------------------------------
-- Automatically return to Insert mode when opening a file
-----------------------------------------------------------

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        if vim.bo.buftype == "" then
            vim.cmd("startinsert")
        end
    end,
})

-----------------------------------------------------------
-- Start in Insert mode
-----------------------------------------------------------

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("startinsert")
    end,
})
