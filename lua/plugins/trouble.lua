return {
	"trouble.nvim",
	cmd = { "Trouble", "TroubleToggle" },
	keys = {
		"<leader>tq",
		"<leader>tl",
		"<leader>tr",
		"<leader>tdw",
		"<leader>tdb",
	},
	beforeAll = function()
		require("keymaps.trouble")
	end,
	after = function()
		require("config.trouble").setup()
	end,
}
