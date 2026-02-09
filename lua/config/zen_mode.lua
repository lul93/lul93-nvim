local M = {}

function M.setup()
	require("zen-mode").setup({
		window = {
			width = 90,
			options = {
				number = false,
				relativenumber = false,
			},
		},
	})
end

return M
