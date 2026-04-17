local enable = true

return {
	"snacks.nvim",
	enabled = enable,

	event = "User PostStartup",

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
