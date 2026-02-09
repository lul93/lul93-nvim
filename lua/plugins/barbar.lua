return {
	"barbar.nvim",
	beforeAll = function()
		require("keymaps.barbar")
	end,
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	after = function()
		require("config.barbar").setup()
	end,
}
