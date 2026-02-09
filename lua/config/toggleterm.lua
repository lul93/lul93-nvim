local M = {}
local debug = false
local function size()
	return {
		h = 15,
		v = math.floor(vim.o.columns * 0.4),
	}
end
local function print_debug(msg)
	if debug then
		print(msg)
	end
end

function M.setup()
	require("toggleterm").setup({
		size = function(t)
			print_debug("before on_open")
			if t.direction == "horizontal" then
				return size().h
			elseif t.direction == "vertical" then
				return size().v
			end
		end,
		on_open = function(t)
			t.tab = vim.api.nvim_win_get_tabpage(t.window)
			print_debug("Set last_terminal")
			require("state").last_terminal = t
		end,
		on_close = function(t)
			t.tab = nil
			require("helper").goto_last_editor_window()
		end,
		on_exit = function(t)
			if require("state").last_terminal == t then
				require("state").last_terminal = nil
			end
		end,
	})
end

function M.toggle(n, direction)
	local Trouble = require("trouble")
	local Terminal = require("toggleterm.terminal").Terminal
	local helper = require("helper")

	--if diagnosics (Trouble) is open, toggle it
	if Trouble.is_open() then
		Trouble.close()
	end

	--direction helper
	local function get_size(dir)
		if dir == "horizontal" then
			return size().h
		elseif dir == "vertical" then
			return size().v
		else
			return nil
		end
	end

	local terminals = require("toggleterm.terminal").get_all()
	local term = terminals[n]

	helper.set_last_editor_window()

	-- if we are in file explorer, we leave that window first back to prolly the window where we coded
	if helper.is_explorer() then
		helper.goto_prev_window()
	end

	-- create terminal
	if not term then
		print_debug("creating new terminal!")
		print_debug("available terminals:")
		print_debug(vim.inspect(terminals))
		term = Terminal:new({
			count = n,
			direction = direction,
			hidden = true,
			size = get_size(direction),
		})
		term:open() -- this triggers on_create
		return
	end

	-- update direction
	if term.direction ~= direction then
		term:close()
		term.direction = direction
		term:open()
		return
	end

	local is_float = term.direction == "float"
	local is_tab = term.direction == "tab"
	local is_other = term.direction == "horizontal" or term.direction == "vertical"

	if is_float then
		if term:is_open() then
			term:close()
		else
			term:open()
			print_debug("tt startinsert floating")
			helper.start_insert()
		end
	elseif is_tab then
		local isSameTab = term.tab
			and vim.api.nvim_tabpage_is_valid(term.tab)
			and term.tab == vim.api.nvim_get_current_tabpage()
		if term:is_open() then
			if isSameTab then
				term:close()
			end
		else
			term:open()
			print_debug("tt startinsert tab")
			helper.start_insert()
		end
	elseif is_other then
		local is_focused = vim.api.nvim_get_current_win() == term.window
		if not term:is_open() then
			print_debug("not open")
			term:open()
			print_debug("tt startinsert other")
			helper.start_insert()
		elseif is_focused then
			print_debug("focused")
			helper.goto_last_editor_window()
		elseif not is_focused then
			print_debug("not focused")
			vim.api.nvim_set_current_tabpage(vim.api.nvim_win_get_tabpage(term.window))
			vim.api.nvim_set_current_win(term.window)
			print_debug("tt startinsert focused")
			helper.start_insert()
		end
	end
end

function M.fast_terminal()
	local helper = require("helper")
	local state = require("state")
	local last_terminal = state.last_terminal
	print_debug(last_terminal)
	local Trouble = require("trouble")
	if helper.is_explorer() then
		print_debug("triggering tt from explorer")
		helper.goto_last_terminal()
		return
	elseif helper.is_terminal() then
		print_debug("triggering tt from terminal")
		if last_terminal and (last_terminal.direction == "vertical" or last_terminal.direction == "horizontal") then
			print_debug("changing focus from terminal to editor window")
			helper.goto_last_editor_window()
			return
		elseif last_terminal then
			print_debug("closing floating terminal")
			last_terminal:close()
			return
		end
	elseif helper.is_trouble() then
		print_debug("triggering tt from trouble")
		Trouble.close()
		helper.goto_last_terminal()
		return
	else
		print_debug("triggering tt from editor window")
		if last_terminal then
			print_debug("last terminal is set")
			if Trouble.is_open() then
				Trouble.close()
			end
			helper.goto_last_terminal()
			return
		else
			print_debug("we go to terminal 1 because no last terminal is set")
			M.toggle(1, "horizontal")
			return
		end
	end
	print_debug("reached end of tt without triggering anything!")
end

function M.close_all()
	local terminals = require("toggleterm.terminal").get_all()
	for _, term in pairs(terminals) do
		if term:is_open() then
			term:close()
		end
	end
end

return M
