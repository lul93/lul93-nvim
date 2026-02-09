local M = {}

function M.setup()
	require("barbar").setup({
		exclude_ft = { "terminal", "toggleterm" },
		icons = {
			separator = { left = "", right = "" },
			preset = "default",
		},
		sidebar_filetypes = {
			NvimTree = true,
		},
	})

	-- update NvimTree Folder structure on opening a buffer!
	vim.api.nvim_create_autocmd("BufEnter", {
		callback = function()
			-- ignore special buffers and the tree itself
			if vim.bo.filetype == "NvimTree" then
				return
			end
			if vim.bo.buftype ~= "" then
				return
			end
			if vim.api.nvim_buf_get_name(0) == "" then
				return
			end

			local ok, view = pcall(require, "nvim-tree.view")
			if not ok then
				return
			end

			local api = require("nvim-tree.api")
			-- run after the buffer switch fully settles
			vim.schedule(function()
				if view.is_visible() then
					api.tree.find_file({
						open = true, -- do not open the tree
						focus = false, -- do not steal focus
						update_root = false,
					})
				end
			end)
		end,
	})
end

return M
