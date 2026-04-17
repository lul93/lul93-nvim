local lz = require("lz.n")
local keymap = lz.keymap("zen-mode.nvim")
local map = require("keybinds").bind

map(keymap, "zen_mode_toggle", function()
	require("zen-mode").toggle()
end)
