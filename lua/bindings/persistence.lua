local lz = require("lz.n")
local keymap = lz.keymap("persistence.nvim")
local map = require("keybinds").bind

map(keymap, "persistence_load_last", function()
	require("persistence").load({ last = true })
end)

map(keymap, "persistence_load_cwd", function()
	require("persistence").load()
end)

map(keymap, "persistence_stop", function()
	require("persistence").stop()
end)

map(keymap, "persistence_select", function()
	require("persistence").select()
end)
