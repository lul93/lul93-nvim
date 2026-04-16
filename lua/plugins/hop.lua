local enable = true

return {
	"hop.nvim",
	enabled = enable,
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
		require("hop").setup()
	end,
}
