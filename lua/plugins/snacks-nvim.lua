local enable = true

return {
	"snacks.nvim",
	enabled = enable,
	lazy = false,
	after = function()
		require("snacks").setup({

			input = {
				enabled = true,
			},

			picker = {
				enabled = true,
			},
		})
	end,
}
