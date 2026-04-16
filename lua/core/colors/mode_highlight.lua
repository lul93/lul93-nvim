local M = {}

local api = vim.api

local colors = require("core.colors.palette")

local mode_map = {
	n = colors.normal,
	i = colors.insert,
	v = colors.visual,
	V = colors.visual,
	["\22"] = colors.visual,
	R = colors.replace,
	c = colors.command,
	t = colors.insert, -- optional sane default
}

local groups = {}

local function get_mode()
	local mode = api.nvim_get_mode().mode
	return mode:sub(1, 1)
end

local function apply()
	local mode = get_mode()
	local color = mode_map[mode]
	if not color then
		return
	end

	for _, def in ipairs(groups) do
		local hl = def.transform(color)
		if hl then
			api.nvim_set_hl(0, def.group, hl)
		end
	end
end

function M.register(group, transform)
	local def = {
		group = group,
		transform = transform,
	}

	groups[#groups + 1] = def

	-- force immediate application
	local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
	local color = mode_map[mode]
	if not color then
		return
	end

	local hl = transform(color)
	if hl then
		vim.api.nvim_set_hl(0, group, hl)
	end
end
function M.setup()
	api.nvim_create_autocmd("ModeChanged", {
		callback = apply,
	})

	apply()
end

return M
