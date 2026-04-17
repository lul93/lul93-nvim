local lz = require("lz.n")
local keymap = lz.keymap("toggleterm.nvim")
local debug = false
local kb = require("keybinds")
local map = kb.bind

local function print_debug(...)
	if debug then
		print(table.concat(vim.tbl_map(tostring, { ... }), " "))
	end
end
local function detect_context(helper)
	local rules = {
		{ name = "explorer", pred = helper.is_explorer },
		{ name = "terminal", pred = helper.is_terminal },
		{ name = "trouble", pred = helper.is_trouble },
	}

	for _, r in ipairs(rules) do
		if r.pred() then
			print_debug("context detected: " .. r.name)
			return r.name
		end
	end

	print_debug("context detected: editor")
	return "editor"
end

local function toggle(opts)
	print_debug("toggle: called")

	opts = opts or {}
	local Trouble = require("trouble")
	local Terminal = require("toggleterm.terminal").Terminal
	local helper = require("helper")
	local state = require("state")

	local ctx = detect_context(helper)
	print_debug("context:", ctx)

	local slot = opts.slot or (state.last_terminal and state.last_terminal.count) or 1

	print_debug("slot:", slot)

	local direction = opts.direction
		or (state.last_terminal and state.last_terminal.count == slot and state.last_terminal.direction)
		or "horizontal"

	print_debug("requested direction:", direction)

	local t = state.terminals[slot]

	if not t then
		print_debug("creating terminal", slot, direction)

		t = Terminal:new({
			count = slot,
			direction = direction,
			hidden = true,
		})

		state.terminals[slot] = t
	else
		print_debug("reusing terminal", slot, "current direction:", t.direction, "is_open:", t:is_open())
	end

	if direction ~= t.direction and t:is_open() then
		print_debug("direction change", t.direction, "->", direction)

		t:close()
		print_debug("terminal closed")

		t.direction = direction

		t:open()
		print_debug("terminal reopened with new direction")

		return
	end

	local handlers = {}

	handlers.editor = function()
		print_debug("handler: editor → open")
		if t:is_open() then
			t:focus()
		else
			t:open()
		end
	end

	handlers.terminal = function()
		print_debug("handler: terminal", t.direction)
		if state.last_terminal and state.last_terminal.count ~= slot then
			print_debug("open terminal")
			t:open()
			return
		end

		if t.direction == "float" or t.direction == "tab" then
			print_debug("closing terminal")
			t:close()
		else
			print_debug("jumping to editor window")
			helper.goto_last_editor_window()
		end
	end

	handlers.explorer = function()
		print_debug("handler: explorer → open")
		t:open()
	end

	handlers.trouble = function()
		print_debug("handler: trouble → close trouble + open terminal")
		Trouble.close()
		t:open()
	end

	local h = handlers[ctx] or handlers.editor
	print_debug("dispatch handler:", ctx or "editor")

	return h()
end

local function close_all()
	print_debug("close_all called")

	local state = require("state")
	for slot, term in pairs(state.terminals) do
		if term:is_open() then
			print_debug("closing terminal slot=" .. slot)
			term:close()
		end
	end
end

map(keymap, "toggleterm_toggle", function()
	toggle()
end)

map(keymap, "toggleterm_horizontal", function()
	toggle({ direction = "horizontal" })
end)

map(keymap, "toggleterm_float", function()
	toggle({ direction = "float" })
end)

map(keymap, "toggleterm_tab", function()
	toggle({ direction = "tab" })
end)

map(keymap, "toggleterm_close_all", function()
	close_all()
end)

map(keymap, "toggleterm_exit", [[<C-\><C-n>]])

-- slots: t1..t9
kb.bind_generate(keymap, { 1, 2, 3, 4, 5, 6, 7, 8, 9 }, function(i)
	return "toggleterm_slot_" .. i,
		{
			lhs = "t" .. i,
			mode = "n",
			desc = "terminal slot " .. i,
		},
		function()
			toggle({ slot = i })
		end
end)

-- slot + direction
local dirs = {
	{ key = "h", dir = "horizontal" },
	{ key = "v", dir = "vertical" },
	{ key = "f", dir = "float" },
	{ key = "a", dir = "tab" },
}

local items = {}
for i = 1, 9 do
	for _, d in ipairs(dirs) do
		items[#items + 1] = { slot = i, key = d.key, dir = d.dir }
	end
end

kb.bind_generate(keymap, items, function(item)
	return ("toggleterm_slot_dir_%d_%s"):format(item.slot, item.key),
		{
			lhs = ("<leader>t%d%s"):format(item.slot, item.key),
			mode = "n",
			desc = ("terminal: %d (%s)"):format(item.slot, item.dir),
		},
		function()
			toggle({
				slot = item.slot,
				direction = item.dir,
			})
		end
end)
