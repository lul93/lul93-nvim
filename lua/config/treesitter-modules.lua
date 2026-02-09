local M = {}
function M.setup()
	require("treesitter-modules").setup({
		highlight = { enable = true },
	})
end

return M
