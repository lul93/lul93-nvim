local M = {}

local api = vim.api

----------------------------------------------------------------
-- palette cache
----------------------------------------------------------------
local palette_cache = nil

local function get_palette()
	if palette_cache then
		return palette_cache
	end

	local ok, doom = pcall(require, "doom-one.colors")
	if not ok then
		return nil
	end

	palette_cache = (vim.o.background == "light") and doom.light or doom.dark
	palette_cache.bg_num = tonumber(palette_cache.bg:sub(2), 16)

	return palette_cache
end

----------------------------------------------------------------
-- mode -> lualine group
----------------------------------------------------------------
local mode_map = {
	n = "lualine_a_normal",
	i = "lualine_a_insert",
	v = "lualine_a_visual",
	V = "lualine_a_visual",
	["\22"] = "lualine_a_visual",
	c = "lualine_a_command",
	R = "lualine_a_replace",
	t = "lualine_a_terminal",
}

----------------------------------------------------------------
-- hl utils
----------------------------------------------------------------
local function get_bg(name)
	local ok, hl = pcall(api.nvim_get_hl, 0, { name = name, link = false })
	if not ok or not hl or not hl.bg then
		return nil
	end
	return hl.bg
end

----------------------------------------------------------------
-- color blend
----------------------------------------------------------------
local function blend(c, b, a)
	local function ch(x, s)
		return bit.rshift(x, s) % 256
	end

	local function mix(fc, bc)
		return math.floor(bc + (fc - bc) * a + 0.5)
	end

	local r = mix(ch(c, 16), ch(b, 16))
	local g = mix(ch(c, 8), ch(b, 8))
	local b2 = mix(ch(c, 0), ch(b, 0))

	return r * 65536 + g * 256 + b2
end

----------------------------------------------------------------
-- winhighlight merge (do not clobber user config)
----------------------------------------------------------------
local function merge_winhighlight(win, pair)
	local current = api.nvim_get_option_value("winhighlight", { win = win })
	if current == "" then
		api.nvim_set_option_value("winhighlight", pair, { win = win })
		return
	end

	if not current:find(pair, 1, true) then
		api.nvim_set_option_value("winhighlight", current .. "," .. pair, { win = win })
	end
end

----------------------------------------------------------------
-- main
----------------------------------------------------------------
function M.setup()
	print("LINENR")
	local function clear(win)
		local current = api.nvim_get_option_value("winhighlight", { win = win })
		if current == "" then
			return
		end

		-- remove only our injected pairs
		current =
			current:gsub("LineNr:ActiveLineNr,?", ""):gsub("CursorLineNr:ActiveCursorLineNr,?", ""):gsub(",+$", "")

		api.nvim_set_option_value("winhighlight", current, { win = win })
	end
	local function apply()
		local cur = api.nvim_get_current_win()

		-- clear every other window first
		for _, win in ipairs(api.nvim_list_wins()) do
			if win ~= cur then
				clear(win)
			end
		end

		local p = get_palette()
		if not p then
			return
		end

		local mode = api.nvim_get_mode().mode:sub(1, 1)
		local group = mode_map[mode] or "lualine_a_normal"

		local mode_bg = get_bg(group)
		if not mode_bg then
			return
		end

		local gutter = blend(mode_bg, p.bg_num, 0.80)

		api.nvim_set_hl(0, "ActiveLineNr", {
			fg = p.bg,
			bg = gutter,
			bold = true,
		})
		api.nvim_set_hl(0, "ActiveCursorLineNr", {
			fg = 0xFFFFFF,
			bg = blend(mode_bg, p.bg_num, 0.35),
			bold = true,
		})

		merge_winhighlight(cur, "LineNr:ActiveLineNr,CursorLineNr:ActiveCursorLineNr")
	end
	----------------------------------------------------------------
	-- autocommands
	----------------------------------------------------------------
	api.nvim_create_autocmd({ "ModeChanged", "WinEnter", "WinLeave", "VimEnter", "ColorScheme" }, { callback = apply })
end

return M
