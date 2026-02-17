local lz = require("lz.n")
local keymap = lz.keymap("flash.nvim")

keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end)

keymap.set("o", "r", function()
	require("flash").remote()
end)
