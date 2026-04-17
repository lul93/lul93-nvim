local lz = require("lz.n")
local keymap = lz.keymap("flash.nvim")
local map = require("keybinds").bind

map(keymap, "flash_jump", function()
	require("flash").jump()
end)

map(keymap, "flash_remote", function()
	require("flash").remote()
end)
