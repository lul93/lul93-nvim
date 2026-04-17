local enable = true

return {
	"smart-splits.nvim",
	enabled = enable,

	beforeAll = function()
		require("bindings.smart-splits")
	end,

	after = function()
		require("smart-splits").setup()
	end,
}
