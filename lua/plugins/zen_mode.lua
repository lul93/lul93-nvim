local enable = true

return {
	"zen-mode.nvim",
	enabled = enable,
	beforeAll = function()
		require("bindings.zen_mode")
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
