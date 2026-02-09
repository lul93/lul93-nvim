return {
	"nvim-surround",
	keys = {
		"ys",
		"ds",
		"cs",
	},
	after = function()
		require("config.nvim-surround").setup()
	end,
}
