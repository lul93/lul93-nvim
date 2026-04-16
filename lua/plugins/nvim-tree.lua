return {
	"nvim-tree.lua",
	event = "VimEnter",
	beforeAll = function()
		require("keymaps.nvim-tree")
	end,
	after = function()
		require("config.nvim-tree").setup()
	end,
}
