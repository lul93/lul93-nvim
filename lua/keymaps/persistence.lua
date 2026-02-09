local lz = require("lz.n")
local keymap = lz.keymap("persistence.nvim")

keymap.set("n", "<leader>pll", function()
	require("persistence").load({ last = true })
end, { desc = "load last session" })

keymap.set("n", "<leader>plc", function()
	require("persistence").load()
end, { desc = "load session for cwd" })

keymap.set("n", "<leader>pS", function()
	require("persistence").stop()
end, { desc = "stop persistence" })

keymap.set("n", "<leader>ps", function()
	require("persistence").select()
end, { desc = "select previous sessions" })
