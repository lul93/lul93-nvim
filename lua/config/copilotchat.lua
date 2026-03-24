local M = {}

M.state = {
	win = nil,
	buf = nil,
}

-- Check if window is valid
local function is_valid(win)
	return win and vim.api.nvim_win_is_valid(win)
end

-- Find copilot chat buffer (by filetype)
local function find_copilot_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) then
			if vim.bo[buf].filetype == "copilot-chat" then
				return buf
			end
		end
	end
	return nil
end

function M.open()
	local helper = require("helper")

	-- If sidebar already exists → just focus it
	if is_valid(M.state.win) then
		vim.api.nvim_set_current_win(M.state.win)
		return
	end

	-- Remember last editor window before opening sidebar
	helper.set_last_editor_window()

	-- Create right sidebar window
	vim.cmd("botright vsplit")
	vim.cmd("vertical resize 50")

	local win = vim.api.nvim_get_current_win()

	-- Open CopilotChat (will attach buffer)
	require("CopilotChat").open()

	-- Copilot can be async → defer buffer assignment
	vim.schedule(function()
		local buf = find_copilot_buf()
		if not buf or not is_valid(win) then
			return
		end

		-- Force buffer into our sidebar window
		vim.api.nvim_win_set_buf(win, buf)

		-- Apply sidebar window options
		vim.wo[win].winfixwidth = true
		vim.wo[win].number = false
		vim.wo[win].relativenumber = false
		vim.wo[win].signcolumn = "no"

		-- Save state
		M.state.win = win
		M.state.buf = buf
	end)
end

function M.go_back()
	-- Jump back to last editor window
	require("helper").goto_last_editor_window()
end

function M.close()
	-- Close sidebar window if valid
	if is_valid(M.state.win) then
		vim.api.nvim_win_close(M.state.win, true)
	end

	-- Reset state
	M.state.win = nil
	M.state.buf = nil
end

function M.open_new()
	-- Close existing session
	M.close()

	-- Open fresh session
	M.open()
end

function M.toggle()
	local helper = require("helper")

	if is_valid(M.state.win) then
		if vim.api.nvim_get_current_win() == M.state.win then
			-- If currently in chat → go back to editor
			helper.goto_last_editor_window()
		else
			-- If in editor → focus chat
			vim.api.nvim_set_current_win(M.state.win)
		end
	else
		-- If not open → open sidebar
		M.open()
	end
end

function M.setup()
	require("CopilotChat").setup({
		insert_at_end = true,
		auto_insert_mode = true,

		-- Important: let us control window placement
		window = {
			layout = "replace",
			width = 0.4,
		},
	})
end

return M
