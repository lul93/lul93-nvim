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
	beforeAll = function()
		require("bindings.trouble")
	end,
	after = function()
		setup()
	end,
}
