local enable = true

return {
	"hop.nvim",
	enabled = enable,
	beforeAll = function()
		require("bindings.hop")
	end,
	after = function()
		require("hop").setup()
	end,
}
