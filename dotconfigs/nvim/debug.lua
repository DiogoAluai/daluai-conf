
-- Print every pressed key
vim.on_key(function(key)
    print("Pressed: " .. vim.fn.keytrans(key))
end)


