-----------------------------------------------------------
-- CUA-style / non-modal Neovim
-----------------------------------------------------------

-- Debug mode
if vim.env.NVIM_DEBUUG == "true" then
    -- Print every pressed key
    vim.on_key(function(key)
        print("Pressed: " .. vim.fn.keytrans(key))
    end)
end


require("config.lazy")
require("bindings").bind()


-- Dynamic diagnostics in insert mode
--  it's also possible to turn it on and off manually. todo: provide bigger buffer before diagnostics
--asd = nil
--asd.();
vim.diagnostic.config({
    update_in_insert = true,
    virtual_text = true,
    signs = true,
    underline = true,
})


vim.api.nvim_set_hl(0, "CursorNormal", {
  fg = "#1e1e2e",
  bg = "#89b4fa",
})

vim.api.nvim_set_hl(0, "CursorInsert", {
  fg = "#1e1e2e",
  bg = "#a6e3a1",
})

vim.api.nvim_set_hl(0, "CursorVisual", {
  fg = "#1e1e2e",
  bg = "#f9e2af",
})


-----------------------------------------------------------
-- Automatically return to Insert mode when opening a file
-----------------------------------------------------------

-- vim.api.nvim_create_autocmd("BufEnter", {
--     callback = function()
--         if vim.bo.buftype == "" then
--             vim.cmd("startinsert")
--         end
--     end,
-- })

-----------------------------------------------------------
-- Start in Insert mode
-----------------------------------------------------------

-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--         vim.cmd("startinsert")
--     end,
-- })
