local enable = true

local function setup()
	local colors = require("core.colors.palette")

	local lua_theme = {
		normal = {
			a = { fg = colors.bg_main, bg = colors.normal, gui = "bold" },
			b = { fg = colors.text_main, bg = colors.structure },
			c = { fg = colors.text_main, bg = colors.bg_ui },
		},
		insert = {
			a = { fg = colors.bg_main, bg = colors.insert, gui = "bold" },
		},
		visual = {
			a = { fg = colors.bg_main, bg = colors.visual, gui = "bold" },
		},
		replace = {
			a = { fg = colors.bg_main, bg = colors.replace, gui = "bold" },
		},
		command = {
			a = { fg = colors.bg_main, bg = colors.command, gui = "bold" },
		},
		inactive = {
			a = { fg = colors.text_dim, bg = colors.bg_ui },
			b = { fg = colors.text_dim, bg = colors.structure },
			c = { fg = colors.text_dim, bg = colors.bg_ui },
		},
	}

	require("lualine").setup({
		options = {
			theme = lua_theme,
			globalstatus = true,
		},
		sections = {
			lualine_c = {
				function()
					if vim.bo.filetype == "toggleterm" then
						return "T (" .. vim.b.toggle_number .. ")"
					end
					return ""
				end,
			},
		},
	})
end

return {
	"lualine.nvim",
	enabled = enable,
	lazy = false,
	after = function()
		setup()
	end,
}
