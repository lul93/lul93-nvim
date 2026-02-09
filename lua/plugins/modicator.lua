return {
	"modicator.nvim",
	event = "User PostStartup",
	after = {
		require("modicator").setup(),
	},
}
