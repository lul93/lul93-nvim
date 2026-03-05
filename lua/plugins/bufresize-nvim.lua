return {
	"bufresize.nvim",
	event = "BufWinEnter",
	after = function()
		require("bufresize").setup()
	end,
}
