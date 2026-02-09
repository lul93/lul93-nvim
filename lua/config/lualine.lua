local M = {}
function M.setup()
	local colors = {
		bg = "#21242b",
		fg = "#bbc2cf",
		blue = "#51afef",
		green = "#98be65",
		magenta = "#c678dd",
		red = "#ff6c6b",
		yellow = "#ECBE7B",
	}

	local doom_one = {
		normal = {
			a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
			b = { fg = colors.fg, bg = "#1f232a" },
			c = { fg = colors.fg, bg = colors.bg },
		},
		insert = { a = { fg = colors.bg, bg = colors.green, gui = "bold" } },
		visual = { a = { fg = colors.bg, bg = colors.magenta, gui = "bold" } },
		replace = { a = { fg = colors.bg, bg = colors.red, gui = "bold" } },
		command = { a = { fg = colors.bg, bg = colors.yellow, gui = "bold" } },
		inactive = {
			a = { fg = colors.fg, bg = colors.bg },
			b = { fg = colors.fg, bg = colors.bg },
			c = { fg = colors.fg, bg = colors.bg },
		},
	}

	require("lualine").setup({
		options = {
			theme = doom_one,
			globalstatus = true,
		},
		-- winbar not working as intended with barbar
		-- winbar = {
		-- 	lualine_c = { { "buffers", buffers_color = { active = "lualine_a_normal" } } },
		-- },
		--
		-- inactive_winbar = {
		-- 	lualine_c = { { "filename" } },
		-- },
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

return M
