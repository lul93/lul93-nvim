local M = {}

function M.setup()
	local db = require("dashboard")

	local function footer()
		local datetime = os.date("%A, %d %B %Y  %H:%M")
		local v = vim.version()
		local nvim_ver = string.format("v%d.%d.%d", v.major, v.minor, v.patch)

		return {
			"",
			"󰥔  " .. datetime,
			"  Neovim " .. nvim_ver,
		}
	end
	db.setup({
		theme = "doom",
		config = {
			week_header = {
				enable = true,
			},

			center = {
				{
					icon = "  ",
					icon_hl = "Title",
					desc = "Last session",
					desc_hl = "String",
					key = "l",
					key_hl = "Number",
					key_format = " %s",
					action = function()
						require("persistence").load({ last = true })
					end,
				},
				{
					icon = "  ",
					icon_hl = "Title",
					desc = "Browser",
					desc_hl = "String",
					key = "b",
					key_hl = "Number",
					key_format = " %s",
					action = function()
						require("telescope").extensions.file_browser.file_browser({
							cwd = vim.loop.os_homedir(),
							files = false,
						})
					end,
				},
				{
					icon = "󰙅  ",
					icon_hl = "Title",
					desc = "Projects",
					desc_hl = "String",
					key = "p",
					key_hl = "Number",
					key_format = " %s",
					action = "Telescope projects",
				},
				{
					icon = "  ",
					icon_hl = "Title",
					desc = "New file",
					desc_hl = "String",
					key = "n",
					key_hl = "Number",
					key_format = " %s",
					action = "enew",
				},
				{
					icon = "  ", -- better visual weight than 󰑓
					icon_hl = "Title",
					desc = "Recent Sessions",
					desc_hl = "String",
					key = "s",
					key_hl = "Number",
					key_format = " %s",
					action = function()
						require("persistence").select()
					end,
				},
				{
					icon = "  ",
					icon_hl = "Title",
					desc = "Recent Files",
					desc_hl = "String",
					key = "r",
					key_hl = "Number",
					key_format = " %s",
					action = "Telescope oldfiles",
				},
				{
					icon = "󰱼  ",
					icon_hl = "Title",
					desc = "Search Files",
					desc_hl = "String",
					key = "f",
					key_hl = "Number",
					key_format = " %s",
					action = "Telescope find_files",
				},
				{
					icon = "󰥨  ",
					icon_hl = "Title",
					desc = "Search Folders",
					desc_hl = "String",
					key = "d",
					key_hl = "Number",
					key_format = " %s",
					action = function()
						require("telescope.builtin").find_files({
							prompt_title = "Directories",
							cwd = vim.loop.os_homedir(),
							find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
						})
					end,
				},
			},
			footer = footer(),
		},
	})
end

return M
