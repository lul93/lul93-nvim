local M = {}

function M.setup()
	require("persistence").setup({
		options = { "buffers", "curdir", "tabpages", "winsize", "globals", "terminal", "options" },
		pre_save = function()
			vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
		end,
		need = 1,
	})
	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			require("persistence").save()
		end,
	})

	local helper = require("helper")

	vim.api.nvim_create_autocmd("User", {
		pattern = "PersistenceSavePre",
		callback = function()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.bo[buf].buftype == "terminal" then
					local job = vim.b[buf].terminal_job_id
					if job then
						pcall(vim.fn.jobstop, job) -- kill shell
					end
					pcall(vim.api.nvim_buf_delete, buf, { force = true })
				end
			end
			-- vim.cmd(":Trouble close")
			-- helper.close_terminals()
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		pattern = "PersistenceLoadPost",
		callback = function()
			local api = require("nvim-tree.api")

			helper.set_last_editor_window()
			if helper.has_nvimtree_placeholder() and not api.tree.is_visible() then
				vim.cmd("silent! NvimTreeOpen")
			end

			vim.schedule(function()
				vim.defer_fn(function()
					vim.api.nvim_exec_autocmds("User", {
						pattern = "SessionLayoutReady",
					})
				end, 50)
			end)
		end,
	})
end

return M
