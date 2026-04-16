local mode_hl = require("core.colors.mode_highlight")
local colors = require("core.colors.palette")

local M = {}

local api = vim.api
local fn = vim.fn

local parts = {}

local function clear()
	for _, w in ipairs(parts) do
		if api.nvim_win_is_valid(w) then
			api.nvim_win_close(w, true)
		end
	end
	parts = {}
end

local function open_win(row, col, width, height, lines, z)
	if width < 1 or height < 1 then
		return
	end

	local buf = api.nvim_create_buf(false, true)

	local win = api.nvim_open_win(buf, false, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		focusable = false,
		zindex = z or 60,
	})

	vim.wo[win].winblend = 100

	api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	for i = 0, #lines - 1 do
		api.nvim_buf_add_highlight(buf, -1, "FocusBorder", i, 0, -1)
	end

	parts[#parts + 1] = win
end

local function get_geom(win)
	local pos = fn.win_screenpos(win)
	if pos[1] <= 0 or pos[2] <= 0 then
		return nil
	end

	return {
		row = pos[1] - 1,
		col = pos[2] - 1,
		width = api.nvim_win_get_width(win),
		height = api.nvim_win_get_height(win),
	}
end

local function has_neighbor(win, dir)
	local cur = api.nvim_get_current_win()
	api.nvim_set_current_win(win)
	local id = fn.win_getid(fn.winnr(dir))
	api.nvim_set_current_win(cur)
	return id ~= 0 and id ~= win
end

local function vline(h)
	local t = {}
	for i = 1, h do
		t[i] = "│"
	end
	return t
end

local function hline(w)
	return { string.rep("─", w) }
end

local function draw()
	clear()

	local win = api.nvim_get_current_win()
	local g = get_geom(win)
	if not g then
		return
	end

	local row, col, w, h = g.row, g.col, g.width, g.height

	local L = has_neighbor(win, "h")
	local R = has_neighbor(win, "l")
	local U = has_neighbor(win, "k")
	local D = has_neighbor(win, "j")

	if L then
		open_win(row, col - 1, 1, h, vline(h))
	end
	if R then
		open_win(row, col + w, 1, h, vline(h))
	end
	if U then
		open_win(row - 1, col, w, 1, hline(w))
	end
	if D then
		open_win(row + h, col, w, 1, hline(w))
	end

	if U and L then
		open_win(row - 1, col - 1, 1, 1, { "┌" }, 70)
	end
	if U and R then
		open_win(row - 1, col + w, 1, 1, { "┐" }, 70)
	end
	if D and L then
		open_win(row + h, col - 1, 1, 1, { "└" }, 70)
	end
	if D and R then
		open_win(row + h, col + w, 1, 1, { "┘" }, 70)
	end
end

local function update()
	local win = api.nvim_get_current_win()
	local cfg = api.nvim_win_get_config(win)

	if cfg.relative ~= "" then
		clear()
		return
	end

	draw()
end

function M.setup()
	mode_hl.register("FocusBorder", function(color)
		return {
			fg = color,
			bg = "None",
			nocombine = true,
			blend = 0,
		}
	end)

	api.nvim_create_autocmd({
		"WinEnter",
		"BufEnter",
		"WinResized",
		"VimResized",
		"ModeChanged",
	}, {
		callback = update,
	})

	-- force highlight to exist before first draw
	mode_hl.setup()
	update()
end

return M
