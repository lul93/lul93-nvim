local M = {}

function M.setup()
	require("project").setup({
		use_lsp = true,
		patterns = { ".git", "flake.nix", "package.json", ".project" },
		silent_chdir = true,
		different_owners = {
			allow = true,
			notify = false,
		},
	})
end

return M
