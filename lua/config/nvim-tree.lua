local M = {}
local helper = require("helper")
function M.setup()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
	vim.g.nvim_tree_respect_buf_cwd = 1
	vim.g.nvim_tree_follow = 1
	local function search_replace_on_node()
		local api = require("nvim-tree.api")
		local node = api.tree.get_node_under_cursor()

		if not node or not node.absolute_path then
			vim.notify("no node")
			return
		end

		local path = vim.fn.fnameescape(node.absolute_path)

		local target
		if node.type == "directory" then
			target = path .. "/**/*"
		else
			target = path
		end

		local search = vim.fn.input("search: ")
		if search == "" then
			return
		end

		local replace = vim.fn.input("replace: ")

		-- use # as delimiter to avoid slash conflicts
		local esc_search = vim.fn.escape(search, [[#\]])
		local esc_replace = vim.fn.escape(replace, [[#\&]])

		vim.cmd("silent! vimgrep #" .. esc_search .. "#gj " .. target)
		vim.cmd("cfdo %s#" .. esc_search .. "#" .. esc_replace .. "#g | update")

		vim.notify("done")
	end

	print("nvim tree loading inside setup")
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
			preserve_window_proportions = true,
			number = true,
			adaptive_size = true,
			width = {
				min = 20,
				max = 90,
			},
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

		on_attach = function(bufnr)
			local api = require("nvim-tree.api")

			api.map.on_attach.default(bufnr)

			vim.keymap.set("n", "sr", search_replace_on_node, {
				buffer = bufnr,
				noremap = true,
				silent = true,
			})
		end,
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
