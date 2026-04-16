-- file: lua/core/reveal/jumplist.lua

local M = {}

local function get_pos()
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_win_get_buf(win)
	local cur = vim.api.nvim_win_get_cursor(win)
	return win, buf, cur[1], cur[2]
end

function M.setup()
	local effects = require("core.reveal.effects")
	local set = vim.keymap.set

	local function wrap(key)
		set("n", key, function()
			local win0, buf0, line0, col0 = get_pos()

			-- let Neovim handle the jump natively
			vim.schedule(function()
				local win1, buf1, line1, col1 = get_pos()

				local moved = win0 ~= win1 or buf0 ~= buf1 or line0 ~= line1 or col0 ~= col1

				if moved then
					effects.run()
				end
			end)

			return key
		end, { expr = true, silent = true })
	end

	wrap("<C-o>")
	wrap("<C-i>")
end

return M
