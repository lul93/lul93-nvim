local lz = require("lz.n")
local keymap = lz.keymap("conform.nvim")
local map = require("keybinds").bind

map(keymap, "conform_format", function()
	require("conform").format({
		async = true,
		lsp_fallback = true,
	})
end)
