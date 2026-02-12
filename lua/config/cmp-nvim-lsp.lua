local M = {}

function M.setup()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- Lua
	vim.lsp.config.lua_ls = {
		capabilities = capabilities,
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
				diagnostics = { globals = { "vim" } },
			},
		},
	}

	-- Python
	vim.lsp.config.pyright = {
		capabilities = capabilities,
	}

	-- Nix
	vim.lsp.config.nil_ls = {
		capabilities = capabilities,
	}

	-- Bash
	vim.lsp.config.bashls = {
		capabilities = capabilities,
	}

	-- C/C++
	vim.lsp.config.clangd = {
		cmd = {
			"clangd",
			"--header-insertion=iwyu",
			"--header-insertion-decorators",
		},
		capabilities = capabilities,
	}

	-- Meson
	vim.lsp.config.mesonlsp = {
		capabilities = capabilities,
	}

	-- HTML
	vim.lsp.config.html = {
		capabilities = capabilities,
		filetypes = { "html", "templ", "htmldjango" },
	}

	-- CSS
	vim.lsp.config.cssls = {
		capabilities = capabilities,
		settings = {
			css = { validate = true },
			scss = { validate = true },
			less = { validate = true },
		},
	}

	-- enable servers
	vim.lsp.enable({
		"lua_ls",
		"pyright",
		"nil_ls",
		"bashls",
		"clangd",
		"mesonlsp",
		"html",
		"cssls",
	})
end

return M
