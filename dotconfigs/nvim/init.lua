

-----------------------------------------------------------
-- CUA-style / non-modal Neovim
-----------------------------------------------------------

--asd = nil
--asd.();


-- Debug mode
if vim.env.NVIM_DEBUUG == "true" then
    -- Print every pressed key
    vim.on_key(function(key)
        print("Pressed: " .. vim.fn.keytrans(key))
    end)
end


require("config.lazy")
require("bindings").bind()

-- Example Treesitter query:
-- vim.cmd("hi @function.builtin guifg=orange")
-- :InspectTree to check the tree

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
