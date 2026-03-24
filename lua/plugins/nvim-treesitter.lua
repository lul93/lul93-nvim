return {
	"nvim-treesitter",
	lazy = false,
	after = function()
		require("config.nvim-treesitter").setup()
	end,
}
