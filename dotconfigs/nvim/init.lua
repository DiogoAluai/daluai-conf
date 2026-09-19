
-----------------------------------------------------------
-- CUA-style / non-modal Neovim
-----------------------------------------------------------

if vim.env.NVIM_DEBUUG == "true" then
    -- Print every pressed key
    vim.on_key(function(key)
        print("Pressed: " .. vim.fn.keytrans(key))
    end)
end




require("config.lazy")

require("bindings").bind()

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
