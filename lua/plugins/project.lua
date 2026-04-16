local enable = true
local function setup()
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

return {
	"project.nvim",
	enabled = enable,
	-- lazy = false,
	-- event = { "BufReadPre", "BufNewFile" },
	event = "VimEnter",
	after = function()
		setup()
	end,
}
