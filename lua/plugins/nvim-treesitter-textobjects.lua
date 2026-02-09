return {
	"nvim-treesitter-textojects",
	beforeAll = function()
		require("keymaps.nvim-treesitter-textobjects")
	end,
	keys = {
		"]",
		"a",
		"i",
	},
	after = function()
		require("config.nvim-treesitter-textobjects")
	end,
}
