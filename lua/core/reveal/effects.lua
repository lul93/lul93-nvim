local M = {}

local config = {
	scroll_mode = "center",
	hl = "CursorLine",
	cycles = 2,
	persist = false,
}

function M.setup(opts)
	config = vim.tbl_extend("force", config, opts or {})
end

function M.run()
	print("running effects!")
	local ok_blink, blink = pcall(require, "core.reveal.blink")
	local ok_scroll, scroll = pcall(require, "core.reveal.scroll")

	if not (ok_blink and ok_scroll) then
		return
	end

	local win = vim.api.nvim_get_current_win()
	if not vim.api.nvim_win_is_valid(win) then
		return
	end

	local buf = vim.api.nvim_win_get_buf(win)
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end

	local line = vim.api.nvim_win_get_cursor(win)[1]

	scroll.run(win, line, config.scroll_mode)

	blink.run(buf, line, line, {
		hl = config.hl,
		cycles = config.cycles,
		persist = config.persist,
	})
end

return M
