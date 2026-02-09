local M = {}
function M.setup()
	require("nvim-treesitter").setup({
		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = { enable = true },
	})
end

return M
