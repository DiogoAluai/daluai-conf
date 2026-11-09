-----------------------------------------------------------
-- CUA-style / non-modal Neovim
-----------------------------------------------------------

-- Debug mode
if vim.env.NVIM_DEBUUG == "true" then
    -- Print every pressed key
    vim.on_key(function(_, typed)
        if typed and typed ~= "" then
            print("Pressed: " .. vim.fn.keytrans(typed))
        end
    end)
end

require("config.lazy")
require("bindings").bind()

-- Dynamic diagnostics in insert mode
--  it's also possible to turn it on and off manually. todo: provide bigger time buffer before diagnostics hint show
--asd = nil
--asd.();
vim.diagnostic.config({
    update_in_insert = true,
    virtual_text = true,
    signs = true,
    underline = true,
})

-- WRAPPING
-- todo: find better place for the wrapping logic
-- todo: add scrollability to both help buffers and python lib files
-- todo: add wrapping to help buffers
-- Line wrapping for markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true             -- Enable line wrapping
        --         vim.opt_local.linebreak = true   -- Break lines at word boundaries
        --         vim.opt_local.textwidth = 80     -- Set text width for auto-wrapping
        --      Screen navigation
        vim.keymap.set("n", "<Down>", "gj", { buffer = true })
        vim.keymap.set("i", "<Down>", "<C-o>gj", { buffer = true })
        vim.keymap.set("n", "<Up>", "gk", { buffer = true })
        vim.keymap.set("i", "<Up>", "<C-o>gk", { buffer = true })
    end,
})
-- Line wrapping for Python library source
vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter" }, {
    pattern = { "*/site-packages/*", "*/dist-packages/*", "*/lib/python3*/*" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.keymap.set("n", "<Down>", "gj", { buffer = true })
        vim.keymap.set("i", "<Down>", "<C-o>gj", { buffer = true })
        vim.keymap.set("n", "<Up>", "gk", { buffer = true })
        vim.keymap.set("i", "<Up>", "<C-o>gk", { buffer = true })
    end,
})
------

require("oil-extension")
require("multiline")
