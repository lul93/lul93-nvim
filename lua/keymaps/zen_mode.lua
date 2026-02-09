local lz = require("lz.n")
local keymap = lz.keymap("zen_mode.nvim")

keymap.set("n", "<leader>tz", function()
	require("zen-mode").toggle()
end, { desc = "Toggle Zen Mode" })
