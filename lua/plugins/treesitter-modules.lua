return {
	"treesitter-modules.nvim",
	beforeAll = function()
		require("keymaps.treesitter-modules")
	end,
	keys = {
		"<CR>",
		"<Tab>",
		"<S-Tab>",
	},
	after = function()
		require("config.treesitter-modules")
	end,
}
