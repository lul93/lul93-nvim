local enable = true

return {
	"bufresize.nvim",
	enabled = enable,
	event = "BufWinEnter",
	after = function()
		require("bufresize").setup()
	end,
}
