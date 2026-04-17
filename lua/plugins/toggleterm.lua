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
			local state = require("state")

			-- assign slot if missing
			if not t.count then
				local max = 0
				for k in pairs(state.terminals) do
					if k > max then
						max = k
					end
				end

				t.count = max + 1
			end

			state.terminals[t.count] = t
			state.last_terminal = t

			print_debug("terminal opened (count=" .. tostring(t.count) .. ", dir=" .. tostring(t.direction) .. ")")
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
		require("bindings.toggleterm")
	end,
	after = function()
		setup()
	end,
}
