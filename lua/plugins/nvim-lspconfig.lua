local enable = true

return {
	{
		"nvim-lspconfig",
		enabled = enable,
		event = { "User PostStartup" },
		after = function()
			require("config.lsp").setup()
		end,
	},
}
