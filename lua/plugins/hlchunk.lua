local enable = true

local function setup()
	local c = require("core.colors.palette")

	require("hlchunk").setup({
		chunk = {
			enable = true,
			style = {
				{ fg = c.accent_blue_dark }, -- active scope
				{ fg = c.bg_cursorline }, -- depth / subtle boundary
			},
		},
		indent = {
			enable = true,
			style = {
				{ fg = c.structure },
			},
		},
		line_num = {
			enable = false,
		},
		blank = {
			enable = false,
		},
	})
end

return {
	"hlchunk.nvim",
	enabled = enable,
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		setup()
	end,
}
