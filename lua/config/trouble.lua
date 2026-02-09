local M = {}

function M.setup()
	require("trouble").setup({
		focus = true,
		follow = true,
		auto_preview = false,
		use_diagnostic_signs = true,
	})
end

return M
