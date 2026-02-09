return {
	"comment.nvim",
	beforeAll = function()
		require("keymaps.comment")
	end,
	event = "User PostStartup",
	after = {
		require("Comment").setup(),
	},
}
