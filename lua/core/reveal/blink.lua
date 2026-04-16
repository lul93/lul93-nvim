local M = {}

-- namespace for all extmarks used by this module
local ns = vim.api.nvim_create_namespace("blink_highlight")

-- per-buffer runtime state
-- {
--   [bufnr] = {
--     gen = number,        -- generation counter to invalidate old timers
--     timer = uv_timer,    -- active timer
--     cursorline = table,  -- saved cursorline state per window
--   }
-- }
local state = {}

-- safely stop + close a libuv timer (idempotent)
local function safe_stop_close(timer)
	if not timer then
		return
	end

	pcall(timer.stop, timer)

	if not timer:is_closing() then
		pcall(timer.close, timer)
	end
end

-- return all valid windows currently displaying a buffer
local function get_buf_windows(bufnr)
	local wins = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == bufnr then
			table.insert(wins, win)
		end
	end
	return wins
end

-- disable cursorline in all windows showing this buffer
-- returns previous values so they can be restored later
local function disable_cursorline_for_buf(bufnr)
	local wins = get_buf_windows(bufnr)
	local saved = {}

	for _, win in ipairs(wins) do
		saved[win] = vim.api.nvim_get_option_value("cursorline", { win = win })
		vim.api.nvim_set_option_value("cursorline", false, { win = win })
	end

	return saved
end

-- restore cursorline state per window (best-effort)
local function restore_cursorline(saved)
	if not saved then
		return
	end

	for win, value in pairs(saved) do
		if vim.api.nvim_win_is_valid(win) then
			pcall(vim.api.nvim_set_option_value, "cursorline", value, { win = win })
		end
	end
end

-- reuse CursorLine styling when requested
vim.api.nvim_set_hl(0, "BlinkCursorLine", { link = "CursorLine" })

function M.run(bufnr, start_line, end_line, opts)
	print("running blinkin")
	opts = opts or {}

	-- guard: invalid buffer
	if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end

	-- initialize state slot
	state[bufnr] = state[bufnr] or {
		gen = 0,
		timer = nil,
		cursorline = nil,
	}

	local s = state[bufnr]

	-- bump generation: invalidates any previous timer callbacks
	s.gen = s.gen + 1
	local my_gen = s.gen

	-- clean up any previous run
	if s.timer then
		safe_stop_close(s.timer)
		s.timer = nil
	end

	if s.cursorline then
		restore_cursorline(s.cursorline)
		s.cursorline = nil
	end

	-- options
	local interval = opts.interval or 350
	local cycles = opts.cycles or 2
	local hl = opts.hl or "IncSearch"
	local persist = opts.persist ~= false

	-- special handling: CursorLine requires disabling real cursorline
	local is_cursorline = (hl == "CursorLine")
	if is_cursorline then
		hl = "BlinkCursorLine"
	end

	-- clamp range to valid buffer lines
	local max = vim.api.nvim_buf_line_count(bufnr)
	start_line = math.min(math.max(1, start_line), max)
	end_line = math.min(end_line or start_line, max)

	-- apply highlight to range
	local function apply()
		vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
		for l = start_line, end_line do
			vim.api.nvim_buf_set_extmark(bufnr, ns, l - 1, 0, {
				line_hl_group = hl,
			})
		end
	end

	-- clear highlight
	local function clear()
		vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
	end

	-- check if any window's cursor is inside the target range
	-- (multi-window safe)
	local function cursor_in_range()
		for _, win in ipairs(get_buf_windows(bufnr)) do
			local cursor = vim.api.nvim_win_get_cursor(win)
			local line = cursor[1]
			if line >= start_line and line <= end_line then
				return true
			end
		end
		return false
	end

	-- blink state
	local visible = is_cursorline and true or false
	local count = 0
	local max_toggles = cycles * 2

	-- disable cursorline while blinking (avoids visual conflict)
	s.cursorline = disable_cursorline_for_buf(bufnr)

	local timer = vim.loop.new_timer()
	s.timer = timer

	timer:start(0, interval, function()
		-- schedule into main loop (required for API calls)
		vim.schedule(function()
			-- generation mismatch => stale timer
			if not state[bufnr] or state[bufnr].gen ~= my_gen then
				safe_stop_close(timer)
				return
			end

			-- buffer deleted
			if not vim.api.nvim_buf_is_valid(bufnr) then
				safe_stop_close(timer)
				if state[bufnr] and state[bufnr].cursorline then
					restore_cursorline(state[bufnr].cursorline)
					state[bufnr].cursorline = nil
				end
				return
			end

			-- cursor moved out of range => terminate early
			if not cursor_in_range() then
				safe_stop_close(timer)

				if state[bufnr] and state[bufnr].gen == my_gen then
					clear()
					restore_cursorline(state[bufnr].cursorline)
					state[bufnr].cursorline = nil
					state[bufnr].timer = nil
				end
				return
			end

			-- toggle visibility
			if visible then
				clear()
			else
				apply()
			end

			visible = not visible
			count = count + 1

			-- finished all cycles
			if count >= max_toggles then
				safe_stop_close(timer)

				if state[bufnr] and state[bufnr].gen == my_gen then
					if persist then
						apply()
					else
						clear()
					end

					restore_cursorline(state[bufnr].cursorline)
					state[bufnr].cursorline = nil
					state[bufnr].timer = nil
				end
			end
		end)
	end)
end

return M
