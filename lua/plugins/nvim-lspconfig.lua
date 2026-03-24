return {
	{
		"nvim-lspconfig",
		event = { "User PostStartup" },
		after = function()
			require("config.lsp").setup()
		end,
	},
}
