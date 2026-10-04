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
--  it's also possible to turn it on and off manually. todo: provide bigger time buffer before diagnostics hint show
--asd = nil
--asd.();
vim.diagnostic.config({
    update_in_insert = true,
    virtual_text = true,
    signs = true,
    underline = true,
})


require("oil-extension")


