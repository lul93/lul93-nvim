return {
	"nvim-tree.lua",
	-- lazy = false,
	event = "VimEnter",
	beforeAll = function()
		require("keymaps.nvim-tree")
	end,
	after = function()
		vim.schedule(function()
			require("nvim-tree").setup()
		end)
	end,
}
