local M = {
	size = { h = 15, v = vim.o.columns * 0.4 },
}
local debug = false
local function print_debug(msg)
	if debug then
		print(msg)
	end
end

function M.goto_last_terminal()
	local state = require("state")
	local last_terminal = state.last_terminal
	if last_terminal then
		if not last_terminal:is_open() then
			last_terminal:open()
			return
		end

		if not last_terminal.tab then
			print_debug("last_t tab nil")
			return
		end
		if not last_terminal.window then
			print_debug("last_t window nil")
			return
		end
		if not vim.api.nvim_win_is_valid(last_terminal.window) then
			print_debug("last_t window not valid")
			last_terminal:open()
			return
		end

		vim.api.nvim_set_current_tabpage(last_terminal.tab)
		vim.api.nvim_set_current_win(last_terminal.window)
		print_debug("goto last terminal startinsert")
		M.start_insert()
	end
end

function M.is_terminal()
	return vim.bo.buftype == "terminal" or vim.bo.filetype == "toggleterm"
end

function M.is_trouble()
	return vim.bo.filetype == "trouble"
end

function M.is_explorer()
	return vim.bo.filetype == "NvimTree"
end

function M.goto_prev_window()
	vim.cmd.wincmd("p")
end

function M.is_editor_window()
	return not (M.is_terminal() or M.is_explorer() or M.is_trouble())
end

function M.start_insert()
	vim.schedule(function()
		vim.cmd("startinsert!")
	end)
end

function M.goto_last_editor_window()
	local state = require("state")
	local helper = require("helper")
	local last_editor_window = state.last_editor_window
	if not last_editor_window.tab or not last_editor_window.win then
		print_debug("no last editor tab or window")
		return
	end
	if not vim.api.nvim_tabpage_is_valid(last_editor_window.tab) then
		print_debug("last editor tab is not valid")
		return
	end
	if not vim.api.nvim_win_is_valid(last_editor_window.win) then
		print_debug("last editor window is not valid")
		return
	end

	if vim.api.nvim_get_current_win() == last_editor_window.win then
		print_debug("try fallback to last window instead of using last_editor_window")
		helper.goto_prev_window()
	else
		print_debug("swapping to editor window")
		vim.api.nvim_set_current_tabpage(last_editor_window.tab)
		vim.api.nvim_set_current_win(last_editor_window.win)
	end
end

function M.set_last_editor_window()
	print_debug("Set last editor window called")
	local state = require("state")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_win_get_buf(win)
	local last_editor_window = state.last_editor_window
	if not vim.api.nvim_buf_is_valid(buf) then
		print_debug("buffer not valid")
		return
	end

	-- exclude known plugin UIs (do this early)
	local ft = vim.bo[buf].filetype
	if ft == "neo-tree" or ft == "toggleterm" or ft == "trouble" then
		print_debug("exclude known plugins")
		return
	end

	-- must be a normal listed buffer
	if vim.bo[buf].buftype ~= "" then
		print_debug("must be a normal listed buffer 1")
		return
	end
	if vim.bo[buf].buflisted ~= true then
		print_debug("must be a normal listed buffer 2")
		return
	end

	-- must have a real file name
	local name = vim.api.nvim_buf_get_name(buf)
	if not name or name == "" then
		print_debug("must have a real file name")
		return
	end

	-- all checks passed:
	print_debug("set last editor window")
	last_editor_window.tab = vim.api.nvim_get_current_tabpage()
	last_editor_window.win = vim.api.nvim_get_current_win()
end

function M.has_nvimtree_placeholder()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local name = vim.api.nvim_buf_get_name(buf)
			if name:match("NvimTree_%d+") then
				return true
			end
		end
	end
	return false
end

function M.close_all_toggleterms()
	local ok, terms = pcall(require, "toggleterm.terminal")
	if not ok then
		return
	end

	-- get all created terminals
	local terminals = terms.get_all()

	for _, term in pairs(terminals) do
		if term:is_open() then
			term:shutdown() -- kill job
			term:close() -- close window/buffer
		else
			term:shutdown()
		end
	end
end

return M
