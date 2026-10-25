local mc = require("multicursor-nvim")
-- Alt+J: add cursor at next match; Alt+Shift+J: skip it
vim.keymap.set({ "n", "x", "i" }, "<M-j>", function() mc.matchAddCursor(1) end)
vim.keymap.set({ "n", "x", "i" }, "<M-J>", function() mc.matchSkipCursor(1) end)
vim.keymap.set("n", "<C-leftmouse>", mc.handleMouse)
vim.keymap.set("n", "<middledrag>", mc.handleMouseDrag)

-- Esc clears the cursors
mc.addKeymapLayer(function(layerSet)
    layerSet("n", "<esc>", function() mc.clearCursors() end)
end)
