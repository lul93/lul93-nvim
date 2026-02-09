local M = {}

function M.setup()
	require("telescope").setup({
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({
					-- even more opts
				}),
			},
		},
	})

	require("telescope").load_extension("ui-select")
end

return M
