vim.cmd("hi clear")
vim.g.colors_name = "customTheme"

local palette = {
	-- base palette (role-based naming)
	bg_main = "#1a1b26",
	text_main = "#c8ccd4",
	text_dark = "#c8ccd4",
	text_dim = "#9aa0b5",
	structure = "#4a5173",

	-- mode colors,
	normal = "#51afef",
	insert = "#98be65",
	visual = "#c678dd",
	replace = "#ff6c6b",
	command = "#ECBE7B",

	accent_blue = "#7aa2f7",
	accent_green = "#9ece6a",
	accent_yellow = "#e0af68",
	accent_red = "#e06c75",
	accent_magenta = "#bb9af7",
	accent_cyan = "#7dcfff",

	-- extended accents (hierarchy / subtle variants)
	accent_blue_soft = "#aeb8e6",
	accent_blue_dark = "#6b8fd6",
	accent_green_soft = "#8fcca8",
	accent_yellow_soft = "#d7dbff",
	accent_orange = "#ff9e64",

	-- UI surfaces
	bg_cursorline = "#24283b",
	bg_visual = "#2f334d",
	bg_ui = "#2f334d",
}

return palette
