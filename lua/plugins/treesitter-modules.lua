local enable = true

return {
	"treesitter-modules.nvim",
	enabled = enable,
	beforeAll = function()
		require("keymaps.treesitter-modules")
	end,
	keys = {
		"<CR>",
		"<Tab>",
		"<S-Tab>",
	},
	after = function()
		require("treesitter-modules").setup({
			highlight = { enable = true },
		})
	end,
}
