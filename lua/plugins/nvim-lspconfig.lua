local enable = true

return {
	{
		"nvim-lspconfig",
		enabled = enable,
		event = { "BufReadPre", "BufNewFile" },
		after = function()
			require("config.lsp").setup()
		end,
	},
}
