return {
	"nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	after = function()
		require("config.nvim-treesitter")
	end,
}
