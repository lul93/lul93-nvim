local enable = true

return {
	"comment.nvim",
	enabled = enable,
	beforeAll = function()
		require("keymaps.comment")
	end,
	event = "User PostStartup",
	after = {
		require("Comment").setup(),
	},
}
