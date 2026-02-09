local M = {}
local helper = require("helper")
function M.setup()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
	vim.g.nvim_tree_respect_buf_cwd = 1
	vim.g.nvim_tree_follow = 1

	require("nvim-tree").setup({
		hijack_netrw = true,
		hijack_cursor = true,
		sync_root_with_cwd = true,
		respect_buf_cwd = true,

		live_filter = {
			always_show_folders = false,
		},
		update_focused_file = {
			enable = true,
			update_root = true,
		},

		filesystem_watchers = {
			enable = true,
		},

		actions = {
			open_file = {
				quit_on_open = false,
			},
		},

		renderer = {
			group_empty = true,
			highlight_opened_files = "name",
		},

		view = {
			-- preserve_window_proportions = true,
			number = true,
		},

		diagnostics = {
			enable = true,
		},

		modified = {
			enable = true,
		},

		tab = {
			sync = { open = true, close = true },
		},

		reload_on_bufenter = true,
	})
end

function M.toggle()
	if not helper.is_explorer() then
		helper.set_last_editor_window()
		vim.cmd("NvimTreeFocus")
	else
		helper.goto_last_editor_window()
	end
end

function M.close()
	vim.cmd("NvimTreeClose")
end

return M
