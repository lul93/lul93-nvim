return {
	"cmp-nvim-lsp",
	event = "User PostStartup",
	after = {
		require("config.cmp-nvim-lsp").setup(),
	},
}
