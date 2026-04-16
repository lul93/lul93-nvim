local enable = true

return {
	"smart-splits.nvim",
	enabled = enable,
	beforeAll = function()
		require("keymaps.smart-splits")
	end,

	keys = {
		"<A-h>",
		"<A-j>",
		"<A-k>",
		"<A-l>",
		"<C-h>",
		"<C-j>",
		"<C-k>",
		"<C-l>",
		"<C-\\>",
		"<leader><leader>h",
		"<leader><leader>j",
		"<leader><leader>k",
		"<leader><leader>l",
	},

	after = function()
		require("smart-splits").setup()
	end,
}
