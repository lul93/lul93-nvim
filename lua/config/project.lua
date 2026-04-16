local M = {}

function M.setup()
	require("project").setup({
		lsp = {
			enabled = true,
		},
		patterns = { ".git", "flake.nix", "package.json", ".project" },
		silent_chdir = true,
		different_owners = {
			allow = true,
			notify = false,
		},
	})
end

return M
