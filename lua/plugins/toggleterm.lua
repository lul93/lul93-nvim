return {
	"toggleterm.nvim",
	beforeAll = function()
		require("keymaps.toggleterm")
	end,
	keys = {
		"<leader>tt",
		"<leader>tf",
		"<leader>th",
		"<leader>ta",
		"<leader>ct",
	},

	after = function()
		vim.print("toggleterm after")
		require("config.toggleterm").setup()
	end,
}
