local enable = true

return {
	"neodev.nvim",
	enabled = enable,
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		require("neodev").setup({})
	end,
}
