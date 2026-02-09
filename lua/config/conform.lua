local M = {}

function M.setup()
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			nix = { "alejandra" }, -- or "nixfmt"
			python = { "black" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			sh = { "shfmt" },
			go = { "gofmt" },
		},

		format_on_save = {
			timeout_ms = 2000,
			lsp_fallback = true,
		},
	})
end

return M
