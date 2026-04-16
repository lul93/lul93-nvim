local enable = true

local function setup()
	---@diagnostic disable-next-line: redundant-parameter
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			nix = { "nixfmt" },
			python = { "ruff_format" },
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
		lsp_fallback = true,

		format_on_save = {
			timeout_ms = 2000,
			lsp_fallback = true,
		},
	})
end

return {
	"conform.nvim",
	enabled = enable,
	beforeAll = function()
		require("keymaps.conform")
	end,
	event = { "BufWritePre" },
	after = function()
		setup()
	end,
}
