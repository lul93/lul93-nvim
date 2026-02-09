local lz = require("lz.n")
local keymap = lz.keymap("conform.nvim")

keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format({
		async = true,
		lsp_fallback = true,
	})
end, { desc = "format" })
