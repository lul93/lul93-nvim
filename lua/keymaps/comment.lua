local lz = require("lz.n")
local keymap = lz.keymap("telescope.nvim")

local U = require("Comment.utils")
local cfg = require("Comment.config"):get()

local function toggle_adjacent_comments()
	local buf = 0
	local last = vim.api.nvim_buf_line_count(buf)
	local cur = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-index

	-- context at cursor (needed to resolve comment style)
	local ctx = {
		ctype = U.ctype.linewise,
		cmode = U.cmode.toggle,
		range = { srow = cur, scol = 0, erow = cur, ecol = 0 },
	}

	local lcs, rcs = U.parse_cstr(cfg, ctx)
	if not lcs then
		return
	end

	local is_commented = U.is_commented(lcs, rcs, cfg.padding)

	local function line(n)
		if n < 0 or n >= last then
			return nil
		end
		return vim.api.nvim_buf_get_lines(buf, n, n + 1, false)[1]
	end

	local function commented(n)
		local l = line(n)
		if not l then
			return false
		end
		return is_commented({ l })
	end

	-- must start inside a commented block
	if not commented(cur) then
		return
	end

	-- expand upward
	local s = cur
	while commented(s - 1) do
		s = s - 1
	end

	-- expand downward
	local e = cur
	while commented(e + 1) do
		e = e + 1
	end

	-- fetch block
	local lines = vim.api.nvim_buf_get_lines(buf, s, e + 1, false)

	-- decide mode
	local do_uncomment = is_commented(lines)

	local uncomment = U.uncommenter(lcs, rcs, cfg.padding)
	local comment = U.commenter(lcs, rcs, cfg.padding)

	-- transform
	for i, l in ipairs(lines) do
		lines[i] = do_uncomment and uncomment(l) or comment(l)
	end

	-- write back
	vim.api.nvim_buf_set_lines(buf, s, e + 1, false, lines)
end

keymap.set("n", "<leader>dc", toggle_adjacent_comments, { desc = "delete comment block" })

-- VISUAL MODE: uncomment selection
local function uncomment_visual_selection()
	local api = require("Comment.api")

	-- capture current visual selection BEFORE leaving visual
	local start = vim.fn.getpos("v")
	local finish = vim.fn.getpos(".")

	local s = math.min(start[2], finish[2])
	local e = math.max(start[2], finish[2])

	-- leave visual mode
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)

	-- operate line-by-line using the stored range
	local view = vim.fn.winsaveview()

	for line = s, e do
		vim.api.nvim_win_set_cursor(0, { line, 0 })
		pcall(api.uncomment.linewise.current)
	end

	vim.fn.winrestview(view)
end

vim.keymap.set("x", "<leader>dc", uncomment_visual_selection, { desc = "uncomment selection" })
