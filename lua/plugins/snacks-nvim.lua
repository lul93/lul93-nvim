return {
	"snacks.nvim",
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
