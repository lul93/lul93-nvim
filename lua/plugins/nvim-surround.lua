local enable = true

return {
	"nvim-surround",
	enabled = enable,
	keys = {
		"ys",
		"ds",
		"cs",
	},
	after = function()
		require("nvim-surround").setup()
	end,
}
