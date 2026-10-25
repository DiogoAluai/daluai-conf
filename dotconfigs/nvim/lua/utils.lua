local M = {}

function M.save()
    vim.cmd("update")
end

function M.save_and_exit()
    vim.cmd("update")
    vim.cmd("quit")
end

function M.force_exit()
    vim.cmd("quitall!")
end

local function number_of_listed_buffers()
    local count = 0
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buflisted then
            count = count + 1
        end
    end
    return count
end

function M.quit_if_saved()
    if vim.bo.modified then
        vim.notify("Unsaved changes")
        return
    end
    local numberOfBuffers = number_of_listed_buffers()
    if numberOfBuffers > 1 then
        vim.notify("Bdeleting")
        vim.cmd("bdelete")
    elseif numberOfBuffers == 1 then
        vim.notify("Quitng")
        vim.cmd("quit")
    end
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

--- Smart "Home" key, IntelliJ-style.
---
--- Toggles the cursor between the first non-blank character of the line
--- and column 0:
---   * Anywhere in the line      -> first non-blank character
---   * On first non-blank char   -> column 0
---   * On column 0               -> first non-blank character
---
--- On lines without indentation both targets are column 0.
--- On whitespace-only lines it toggles between the end of the
--- indentation and column 0.
---
--- Works in both normal and insert mode (no `<C-o>` needed).
---@return nil
function M.smart_home()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0)) -- col is 0-based
    local line = vim.api.nvim_get_current_line()

    -- 0-based column of the first non-whitespace char (end of line if blank)
    local first_text = (line:find("%S") or (#line + 1)) - 1

    local target = (col == first_text) and 0 or first_text

    vim.api.nvim_win_set_cursor(0, { row, target })
end

function M.smart_home_into_insert()
    M.smart_home()
    vim.cmd("startinsert")
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

function M.jump_x_or_scroll_y_up(x, y)
    if vim.bo.buftype == "help" then
        vim.cmd("normal! " .. y .. vim.keycode("<C-y>"))
    else
        vim.cmd("normal! " .. x .. "k")
    end
end

function M.jump_x_or_scroll_y_down(x, y)
    if vim.bo.buftype == "help" then
        vim.cmd("normal! " .. y .. vim.keycode("<C-e>"))
    else
        vim.cmd("normal! " .. x .. "j")
    end
end

function M.find()
    vim.api.nvim_echo({ { "Find: ", "ModeMsg" } }, false, {})
    local char = vim.fn.getcharstr()
    execute_str("<Esc>/" .. char)
end

-- iteratively clean up clutter
function M.handle_escape_normal_mode()
    if vim.v.hlsearch == 1 then
        vim.cmd("nohlsearch")
        return
    end
    if vim.bo.buftype == "quickfix" then
        vim.cmd("cclose")
        return
    end
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].buftype == "quickfix" then
            vim.api.nvim_set_current_win(win)
            return
        end
    end
end

-- Escape doesn't jump around, it stays on found
function M.handle_escape_command_mode()
    local type = vim.fn.getcmdtype()
    if type == '/' or type == '?' then
        return '<CR>'
    end
    return '<C-c>'
end

-- Returns file suffix string without the dot
local function get_file_prefix()
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

-- Telescope
------
local telescope_builtin = require('telescope.builtin')
local telescope_actions = require("telescope.actions")
local telescope_themes = require('telescope.themes')

function M.telescope_find_files()
    telescope_builtin.find_files(telescope_themes.get_dropdown {
        previewer = false
    })
end

function M.telescope_find_files_in_config()
    telescope_builtin.find_files(telescope_themes.get_dropdown {
        previewer = false,
        search_dirs = {
            "/home/daluai/.config/kitty",
            vim.fn.stdpath("config")
        }
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
    telescope_builtin.help_tags({
        attach_mappings = function(_, _)
            telescope_actions.select_default:replace(telescope_actions.select_vertical)
            return true -- keep the other default mappings
        end,
    })
end

local function is_py_buffer(bufnr)
    return vim.api.nvim_buf_get_name(bufnr or 0):match("%.py$") ~= nil
end

-- Lsp
------
---@param showWarning? boolean
function M.ruff_organize_imports_if_py(showWarning)
    if showWarning == nil then
        showWarning = true
    end
    if vim.fn.executable("ruff") == 0 then
        vim.notify("ruff not found in PATH", vim.log.levels.ERROR)
        return
    end
    if not is_py_buffer() then
        if showWarning then
            vim.notify("Import optimization is only available for .py files", vim.log.levels.WARN)
        end
        return
    end


    local bufnr = vim.api.nvim_get_current_buf()
    local path = vim.api.nvim_buf_get_name(bufnr)
    if path == "" then
        return
    end

    local input = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n") .. "\n"

    local result = vim.system({
        "ruff", "check",
        "--select", "I",
        "--fix",
        "--exit-zero",
        "--quiet",
        "--stdin-filename", path,
        "-",
    }, {
        stdin = input,
        cwd = vim.fs.dirname(path),
        text = true,
    }):wait()

    if result.code ~= 0 then
        vim.notify("ruff failed:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
        return
    end

    if result.stdout == input then
        return -- already sorted
    end

    local lines = vim.split(result.stdout, "\n", { plain = true })
    if lines[#lines] == "" then
        table.remove(lines)
    end

    local view = vim.fn.winsaveview()
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    vim.fn.winrestview(view)
end

return M
