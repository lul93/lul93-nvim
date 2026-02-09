return {
	"neodev.nvim",
	event = "User PostStartup",
	after = {
		require("neodev").setup({}),
	},
}
