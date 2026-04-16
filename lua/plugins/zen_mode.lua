local enable = true

return {
	"zen-mode.nvim",
	enabled = enable,
	keys = { "<leader>tz" },
	before_all = function()
		require("keymaps.zen-mode")
	end,
	after = function()
		require("zen-mode").setup({
			window = {
				width = 90,
				options = {
					number = false,
					relativenumber = false,
				},
			},
		})
	end,
}
