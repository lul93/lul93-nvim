local enable = true
local function setup()
	require("trouble").setup({
		focus = true,
		follow = true,
		auto_preview = false,
		use_diagnostic_signs = true,
	})
end

return {
	"trouble.nvim",
	enabled = enable,
	cmd = { "Trouble", "TroubleToggle" },
	keys = {
		"<leader>tq",
		"<leader>tl",
		"<leader>tr",
		"<leader>tdw",
		"<leader>tdb",
	},
	beforeAll = function()
		require("keymaps.trouble")
	end,
	after = function()
		setup()
	end,
}
