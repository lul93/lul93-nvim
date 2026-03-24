local M = {}

function M.setup()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	capabilities.offsetEncoding = { "utf-16" }

	local servers = {
		lua_ls = {
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					diagnostics = { globals = { "vim" } },
				},
			},
		},

		pyright = {},
		nil_ls = {},
		bashls = {},

		clangd = {
			cmd = {
				"clangd",
				"--header-insertion=iwyu",
				"--header-insertion-decorators",
			},
		},

		mesonlsp = {},

		html = {
			filetypes = { "html", "templ", "htmldjango" },
		},

		cssls = {
			settings = {
				css = { validate = true },
				scss = { validate = true },
				less = { validate = true },
			},
		},
	}

	for name, config in pairs(servers) do
		config.capabilities = capabilities
		vim.lsp.config[name] = config
	end

	vim.lsp.enable(vim.tbl_keys(servers))
end

return M
