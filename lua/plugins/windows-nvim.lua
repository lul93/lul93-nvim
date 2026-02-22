return {
	"windows.nvim",
	event = "VimEnter",
	after = {
		require("windows").setup({
			autowidth = {
				winwidth = 15,
			},
		}),
	},
}
