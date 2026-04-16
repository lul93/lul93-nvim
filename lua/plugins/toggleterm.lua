local enable = true
local debug = false

local function print_debug(...)
	if debug then
		print(table.concat(vim.tbl_map(tostring, { ... }), " "))
	end
end
local function size()
	local s = {
		h = 15,
		v = math.floor(vim.o.columns * 0.4),
	}
	print_debug("size calculated: h=" .. s.h .. " v=" .. s.v)
	return s
end

local function setup()
	print_debug("setup called")

	require("toggleterm").setup({
		persist_mode = false,
		start_in_insert = false,
		close_on_exit = false,
		size = function(t)
			print_debug("size callback for direction: " .. tostring(t.direction))
			if t.direction == "horizontal" then
				return size().h
			elseif t.direction == "vertical" then
				return size().v
			end
		end,
		on_open = function(t)
			print_debug("terminal opened (count=" .. t.count .. ", dir=" .. t.direction .. ")")
			t.tab = vim.api.nvim_win_get_tabpage(t.window)
			require("state").last_terminal = t
			print_debug("last_terminal updated to count=" .. t.count)
		end,
		on_close = function(t)
			print_debug("terminal closed (count=" .. t.count .. ")")
			t.tab = nil
			require("helper").goto_last_editor_window()
		end,
		on_exit = function(t)
			print_debug("terminal exited (count=" .. t.count .. ")")
			local state = require("state")
			if state.last_terminal == t then
				state.last_terminal = nil
				print_debug("last_terminal cleared on exit")
			end
		end,
	})
end

return {
	"toggleterm.nvim",
	enabled = enable,
	beforeAll = function()
		require("keymaps.toggleterm")
	end,
	keys = {
		"<leader>tt",
		"<leader>tf",
		"<leader>th",
		"<leader>ta",
		"<leader>ct",
	},

	after = function()
		setup()
	end,
}
