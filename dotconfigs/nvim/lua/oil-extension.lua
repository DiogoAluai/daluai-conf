local M = {}

local oil_win, prev_win

local function toggle_oil_sidebar()
    if oil_win and vim.api.nvim_win_is_valid(oil_win) then
        -- toggle off
        vim.api.nvim_win_close(oil_win, true)
        oil_win = nil
        return
    end

    prev_win = vim.api.nvim_get_current_win()

    -- directory of the buffer we're leaving (fallback to cwd)
    local dir = vim.fs.root(0, '.git')
    if dir == "" or vim.bo.filetype == "oil" then
        dir = vim.fn.getcwd()
    end

    vim.cmd("topleft 30vnew") -- far-left, 30 columns wide
    oil_win = vim.api.nvim_get_current_win()
    vim.wo[oil_win].winfixwidth = true
    require("oil").open(dir)
end

-- In the sidebar, <CR> on a file opens it in the previously focused window
vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function(ev)
        vim.keymap.set("n", "<CR>", function()
            local oil = require("oil")
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            if entry and entry.type == "file" and dir
                and prev_win and vim.api.nvim_win_is_valid(prev_win) then
                local path = dir .. entry.name
                if oil_win and vim.api.nvim_win_is_valid(oil_win) then
                    vim.api.nvim_win_close(oil_win, true)
                    oil_win = nil
                end
                vim.api.nvim_set_current_win(prev_win)
                vim.cmd("edit " .. vim.fn.fnameescape(path))
            else
                oil.select() -- directories etc. behave normally
            end
        end, { buffer = ev.buf, desc = "Open in previous window" })
    end,
})

vim.keymap.set({ "v", "i", "n" }, "<C-n>", require("oil").open)
vim.keymap.set("n", "<C-o>", toggle_oil_sidebar, { desc = "Oil sidebar" })

