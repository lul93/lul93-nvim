return {
	"nvim-autopairs",
	keys = {
		"(",
		"[",
		"{",
	},
	after = function()
		require("nvim-autopairs").setup()
	end,
}
