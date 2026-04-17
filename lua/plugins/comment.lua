local enable = true

return {
	"comment.nvim",
	enabled = enable,
	lazy = false,
	beforeAll = function()
		require("bindings.comment")
	end,
	after = {
		require("Comment").setup(),
	},
}
