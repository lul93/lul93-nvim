local enable = true

return {
	"neodev.nvim",
	enabled = enable,
	event = "User PostStartup",
	after = {
		require("neodev").setup({}),
	},
}
