local lz = require("lz.n")
local keymap = lz.keymap("toggleterm.nvim")
local debug = false

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
keymap.set({ "n" }, "<leader>tt", function()
	toggle()
end, { desc = "toggle terminal" })

keymap.set({ "n" }, "<leader>th", function()
	toggle({ direction = "horizontal" })
end, { desc = "toggle terminal" })

keymap.set({ "n" }, "<leader>tf", function()
	toggle({ direction = "float" })
end, { desc = "toggle terminal" })

keymap.set({ "n" }, "<leader>ta", function()
	toggle({ direction = "tab" })
end, { desc = "toggle terminal" })

keymap.set("n", "<leader>tc", function()
	close_all()
end, { desc = "close all terminals" })

-- leave terminal insert mode with esc
keymap.set("t", "<Esc>", [[<C-\><C-n>]])

for i = 1, 9 do
	vim.keymap.set("n", "t" .. i, function()
		require("config.toggleterm").toggle({ slot = i })
	end)
end

-- slot + direction: <leader>t{1..9}{h|f|a|v}
local dirs = {
	h = "horizontal",
	v = "vertical",
	f = "float",
	a = "tab",
}

for i = 1, 9 do
	for k, dir in pairs(dirs) do
		keymap.set("n", ("<leader>t%d%s"):format(i, k), function()
			require("config.toggleterm").toggle({ slot = i, direction = dir })
		end, { desc = ("terminal: %d (%s)"):format(i, dir) })
	end
end
