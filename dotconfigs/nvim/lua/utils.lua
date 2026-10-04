local M = {}

function M.save()
    vim.cmd("update")
end

function M.save_and_exit()
    vim.cmd("update")
    vim.cmd("quit")
end

function M.select_all()
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
M.execute_str = execute_str

local function jump_to_start()
    -- "<C-o> executes something and cames back to insert
    execute_str("<C-o>0")
end
M.jump_to_start = jump_to_start

local function jump_to_end()
    execute_str("<C-o>$")
end
M.jump_to_end = jump_to_end

function M.move_left_across_lines()
    if vim.fn.col(".") == 1 and vim.fn.line(".") > 1 then
        execute_str("<C-o>k") -- up
        jump_to_end()
    else
        vim.cmd("normal! h")
    end
end

function M.move_right_across_lines()
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

function M.jumpt_to_end_into_insert()
    jump_to_end()
    vim.cmd("startinsert")
end

function M.jumpt_to_start_into_insert()
    jump_to_start()
    vim.cmd("startinsert")
end

function M.jump_x_up(x)
    vim.cmd("normal! " .. x .. "k")
end

function M.jump_x_down(x)
    vim.cmd("normal! " .. x .. "j")
end

function M.find()
    vim.api.nvim_echo({ { "Find: ", "ModeMsg" } }, false, {})
    local char = vim.fn.getcharstr()
    execute_str("<Esc>/" .. char)
end

function number_of_loaded_buffers()
    local count = 0

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            count = count + 1
        end
    end

    return count
end

function M.quit_if_saved()
    if vim.bo.modified then
        vim.notify("Unsaved changes")
    else
        vim.notify("Quitting")
        if number_of_loaded_buffers() > 1 then
            vim.cmd("bdelete")
        else
            vim.cmd("quit")
        end
    end
end

-- Returns file suffix string without the dot
function get_file_prefix()
    return vim.fn.expand("%:e")
end

local COMMENT_PREFIXES = {
    ["lua"]  = "--",
    ["js"]   = "//",
    ["ts"]   = "//",
    ["c"]    = "//",
    ["cpp"]  = "//",
    ["h"]    = "//",
    ["py"]   = "#",
    ["rb"]   = "#",
    ["sh"]   = "#",
    ["sql"]  = "--",
    ["vim"]  = '"',
    ["java"] = '//',
}

function M.comment_out_current_line()
    local current_row, current_col = unpack(vim.api.nvim_win_get_cursor(0))
    local comment_prefix = COMMENT_PREFIXES[get_file_prefix()] .. " "
    if not comment_prefix then
        comment_prefix = "// "
    end
    local new_col_location = current_col + #comment_prefix
    local current_line = vim.api.nvim_get_current_line()
    vim.api.nvim_set_current_line(comment_prefix .. current_line)
    local current_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(current_win, { current_row, new_col_location })
end

local telescope_builtin = require('telescope.builtin')
local telescope_themes = require('telescope.themes')

function M.telescope_find_files()
    telescope_builtin.find_files(telescope_themes.get_dropdown {
        previewer = false
    })
end

function M.telescope_find_files_in_config()
    telescope_builtin.find_files(telescope_themes.get_dropdown {
        previewer = false,
        cwd = vim.fn.stdpath("config")
    })
end

function M.telescope_find_all()
    telescope_builtin.live_grep({
        grep_open_files = false, -- this would only find on current open files
    })
end

function M.telescope_find_all_in_config()
    telescope_builtin.live_grep({
        cwd = vim.fn.stdpath("config"),
    })
end

-- Find docs for lua libraries and functions
function M.telescope_live_help()
    telescope_builtin.help_tags()
end

return M
