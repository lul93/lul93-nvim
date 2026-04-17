local M = {}

--flattened runtime lookup
M.maps = {}

-- used to detect duplicate key usage (mode + lhs)
local seen = {}

-- registry primitives
local function add(id, spec)
	if M.maps[id] then
		error("duplicate keybind id: " .. id)
	end
	M.maps[id] = spec
end

local function get(id)
	local m = M.maps[id]
	if not m then
		error("keybind id not found: " .. id)
	end
	return m
end

-- public API to define static maps
function M.map(id, spec)
	add(id, spec)
end

-- grouped maps (pure sugar)
function M.group(prefix, defs)
	for suffix, spec in pairs(defs) do
		add(prefix .. "_" .. suffix, spec)
	end
end

-- binding
function M.bind(keymap, id, rhs, opts)
	local m = get(id)

	if not m.lhs then
		error("keybind missing lhs: " .. id)
	end

	opts = opts or {}

	local mode = opts.mode or m.mode or "n"
	local lhs = opts.lhs or m.lhs

	-- duplicate detection
	local modes = type(mode) == "table" and mode or { mode }
	for _, md in ipairs(modes) do
		local key = md .. "::" .. lhs

		if seen[key] and seen[key] ~= id then
			vim.notify(
				string.format("duplicate keybind: [%s] %s (existing: %s, new: %s)", md, lhs, seen[key], id),
				vim.log.levels.WARN
			)
		else
			seen[key] = id
		end
	end

	keymap.set(
		mode,
		lhs,
		rhs,
		vim.tbl_extend("force", {
			desc = m.desc,
			silent = true,
		}, opts)
	)
end

-- dynamic: define + bind in one pass
function M.bind_generate(keymap, items, build)
	for _, item in ipairs(items) do
		local id, spec, rhs = build(item)

		add(id, spec)
		M.bind(keymap, id, rhs)
	end
end

-- get keys of a group
function M.keys_of(group)
	local out = {}

	local g = M.groups[group]
	if not g then
		return out
	end

	local seen = {}

	for _, spec in pairs(g) do
		if spec.lhs and not seen[spec.lhs] then
			seen[spec.lhs] = true
			out[#out + 1] = spec.lhs
		end
	end

	return out
end

-- export (for README)
function M.export()
	return M.maps
end

-- human readable groups
M.groups = {
	barbar = {
		goto_1 = { lhs = "<A-1>", mode = "n" },
		goto_2 = { lhs = "<A-2>", mode = "n" },
		goto_3 = { lhs = "<A-3>", mode = "n" },
		goto_4 = { lhs = "<A-4>", mode = "n" },
		goto_5 = { lhs = "<A-5>", mode = "n" },
		goto_6 = { lhs = "<A-6>", mode = "n" },
		goto_7 = { lhs = "<A-7>", mode = "n" },
		goto_8 = { lhs = "<A-8>", mode = "n" },
		goto_9 = { lhs = "<A-9>", mode = "n" },

		close = { lhs = "<A-w>", mode = "n" },

		move_prev = { lhs = "<leader>bmp", mode = "n", desc = "move current buffer previous" },
		move_next = { lhs = "<leader>bmn", mode = "n", desc = "move current buffer next" },

		next = { lhs = "<A-Tab>", mode = "n" },
		prev = { lhs = "<A-S-Tab>", mode = "n" },

		close_left = { lhs = "<leader>bl", mode = "n", desc = "close buffers to the left" },
		close_right = { lhs = "<leader>br", mode = "n", desc = "close buffers to the right" },
		close_current = { lhs = "<leader>bc", mode = "n", desc = "close buffer" },
		close_others = { lhs = "<leader>bC", mode = "n", desc = "close all other buffers" },

		pin = { lhs = "<leader>bp", mode = "n", desc = "toggle pin" },
		close_unpinned = { lhs = "<leader>bP", mode = "n", desc = "delete non pinned buffers" },

		order_id = { lhs = "<leader>bob", mode = "n", desc = "order buffer by id" },
		order_name = { lhs = "<leader>bon", mode = "n", desc = "order buffer by name" },
		order_dir = { lhs = "<leader>bod", mode = "n", desc = "order buffer by dir" },
		order_lang = { lhs = "<leader>bol", mode = "n", desc = "order buffer by language" },
		order_window = { lhs = "<leader>bow", mode = "n", desc = "order buffer by window number" },
	},

	comment = {
		toggle_block = { lhs = "<leader>dc", mode = "n", desc = "delete comment block" },
		uncomment_visual = { lhs = "<leader>dc", mode = "x", desc = "uncomment selection" },
	},

	conform = {
		format = { lhs = "<leader>f", mode = { "n", "v" }, desc = "format" },
	},

	copilotchat = {
		toggle = { lhs = "<leader>cc", mode = { "n", "v" }, desc = "Copilot Chat: Toggle" },
		open = { lhs = "<leader>co", mode = "n", desc = "Copilot Chat: Open" },
		close = { lhs = "<leader>cx", mode = "n", desc = "Copilot Chat: Close" },
		back = { lhs = "<leader>cb", mode = "n", desc = "Copilot Chat: Back to editor" },
		new = { lhs = "<leader>cn", mode = "n", desc = "Copilot Chat: New chat" },
		ask = { lhs = "<leader>ca", mode = { "n", "v" }, desc = "Copilot Chat: Ask with context" },
		stop = { lhs = "<leader>cs", mode = "n", desc = "Copilot Chat: Stop" },
	},

	flash = {
		jump = { lhs = "s", mode = { "n", "x", "o" } },
		remote = { lhs = "r", mode = "o" },
	},

	hop = {
		f = { lhs = "f", mode = "" },
		F = { lhs = "F", mode = "" },
		t = { lhs = "t", mode = "" },
		T = { lhs = "T", mode = "" },
	},

	nvim_tree = {
		toggle = { lhs = "<leader>et", mode = "n", desc = "toggle explorer" },
		close = { lhs = "<leader>ec", mode = "n", desc = "close explorer" },
	},

	tsmod = {
		init = { lhs = "<CR>", mode = "n" },
		inc = { lhs = "<Tab>", mode = "x" },
		dec = { lhs = "<S-Tab>", mode = "x" },
		scope = { lhs = "<CR>", mode = "x" },
	},

	tsobj = {
		next_function = { lhs = "]f", mode = { "n", "x", "o" }, desc = "go to next function" },
		prev_function = { lhs = "[f", mode = { "n", "x", "o" }, desc = "go to previous function" },

		next_class = { lhs = "]c", mode = { "n", "x", "o" }, desc = "go to next class" },
		prev_class = { lhs = "[c", mode = { "n", "x", "o" }, desc = "go to previous class" },

		next_conditional = { lhs = "]i", mode = { "n", "x", "o" }, desc = "go to next conditional" },
		prev_conditional = { lhs = "[i", mode = { "n", "x", "o" }, desc = "go to previous conditional" },

		next_parameter = { lhs = "]a", mode = { "n", "x", "o" }, desc = "go to next parameter" },
		prev_parameter = { lhs = "[a", mode = { "n", "x", "o" }, desc = "go to previous parameter" },

		next_argument = { lhs = "]A", mode = { "n", "x", "o" }, desc = "go to next argument" },
		prev_argument = { lhs = "[A", mode = { "n", "x", "o" }, desc = "go to previous argument" },

		select_class_outer = { lhs = "ac", mode = { "x", "o" }, desc = "select around class" },
		select_class_inner = { lhs = "ic", mode = { "x", "o" }, desc = "select inside class" },

		select_scope = { lhs = "as", mode = { "x", "o" }, desc = "select around local scope" },

		select_param_inner = { lhs = "ip", mode = { "o", "x" }, desc = "select inside parameter" },
		select_param_outer = { lhs = "ap", mode = { "o", "x" }, desc = "select around parameter" },

		select_arg_inner = { lhs = "ia", mode = { "o", "x" }, desc = "select inside argument" },
		select_arg_outer = { lhs = "aa", mode = { "o", "x" }, desc = "select around argument" },

		select_func_inner = { lhs = "if", mode = { "o", "x" }, desc = "select inside function" },
		select_func_outer = { lhs = "af", mode = { "o", "x" }, desc = "select around function" },

		select_cond_inner = { lhs = "ii", mode = { "o", "x" }, desc = "select inside conditional" },
		select_cond_outer = { lhs = "ai", mode = { "o", "x" }, desc = "select around conditional" },

		select_loop_inner = { lhs = "il", mode = { "o", "x" }, desc = "select inside loop" },
		select_loop_outer = { lhs = "al", mode = { "o", "x" }, desc = "select around loop" },
	},

	persistence = {
		load_last = { lhs = "<leader>pll", mode = "n", desc = "load last session" },
		load_cwd = { lhs = "<leader>plc", mode = "n", desc = "load session for cwd" },
		stop = { lhs = "<leader>pS", mode = "n", desc = "stop persistence" },
		select = { lhs = "<leader>ps", mode = "n", desc = "select previous sessions" },
	},

	smart = {
		resize_left = { lhs = "<A-h>", mode = "n" },
		resize_down = { lhs = "<A-j>", mode = "n" },
		resize_up = { lhs = "<A-k>", mode = "n" },
		resize_right = { lhs = "<A-l>", mode = "n" },

		move_left = { lhs = "<C-h>", mode = "n" },
		move_down = { lhs = "<C-j>", mode = "n" },
		move_up = { lhs = "<C-k>", mode = "n" },
		move_right = { lhs = "<C-l>", mode = "n" },
		move_prev = { lhs = "<C-\\>", mode = "n" },

		swap_left = { lhs = "<leader><leader>h", mode = "n" },
		swap_down = { lhs = "<leader><leader>j", mode = "n" },
		swap_up = { lhs = "<leader><leader>k", mode = "n" },
		swap_right = { lhs = "<leader><leader>l", mode = "n" },
	},

	telescope = {
		find_files = { lhs = "<leader>sf", mode = "n", desc = "files" },
		buffers = { lhs = "<leader>sb", mode = "n", desc = "open buffers" },
		oldfiles = { lhs = "<leader>sr", mode = "n", desc = "recent files" },
		git_files = { lhs = "<leader>sG", mode = "n", desc = "git files" },
		marks = { lhs = "<leader>sm", mode = "n", desc = "marks" },
		jumplist = { lhs = "<leader>sj", mode = "n", desc = "jumplist" },
		live_grep = { lhs = "<leader>sg", mode = "n", desc = "grep project" },
		grep_string = { lhs = "<leader>sw", mode = "n", desc = "word under cursor" },
		resume = { lhs = "<leader>sp", mode = "n", desc = "resume picker" },
	},

	toggleterm = {
		toggle = { lhs = "<leader>tt", mode = "n", desc = "toggle bottom terminal" },
		horizontal = { lhs = "<leader>th", mode = "n", desc = "toggle horizontal terminal" },
		float = { lhs = "<leader>tf", mode = "n", desc = "toggle floating terminal" },
		tab = { lhs = "<leader>ta", mode = "n", desc = "toggle tabbed terminal" },
		close_all = { lhs = "<leader>tc", mode = "n", desc = "close all terminals" },
		exit = { lhs = "<Esc>", mode = "t" },
	},

	trouble = {
		workspace = { lhs = "<leader>tdw", mode = "n", desc = "toggle workspace diagnostics" },
		buffer = { lhs = "<leader>tdb", mode = "n", desc = "toggle buffer diagnostics" },
		qflist = { lhs = "<leader>tq", mode = "n", desc = "toggle quickfix" },
		loclist = { lhs = "<leader>tl", mode = "n", desc = "toggle local list" },
		references = { lhs = "<leader>tr", mode = "n", desc = "toggle lsp references" },

		next = { lhs = "]x", mode = "n" },
		prev = { lhs = "[x", mode = "n" },
	},

	zen_mode = {
		toggle = { lhs = "<leader>z", mode = "n", desc = "Toggle Zen Mode" },
	},
}

-- flatten groups
for group, defs in pairs(M.groups) do
	for name, spec in pairs(defs) do
		add(group .. "_" .. name, spec)
	end
end

return M
