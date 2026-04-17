local enable = true

return {
	"treesitter-modules.nvim",
	enabled = enable,
	beforeAll = function()
		require("bindings.treesitter-modules")
	end,
	after = function()
		require("treesitter-modules").setup({
			highlight = { enable = true },
		})
	end,
}
