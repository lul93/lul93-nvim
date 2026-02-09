return {
	"hop.nvim",
	beforeAll = function()
		require("keymaps.hop")
	end,
	keys = {
		"f",
		"F",
		"t",
		"T",
	},
	after = function()
		require("config.hop").setup()
	end,
}
