local M = {}

function M.setup()
	local set = vim.api.nvim_set_hl
	local c = require("core.colors.palette")

	local bg_main = c.bg_main
	local text_main = c.text_main
	local text_dim = c.text_dim

	local accent_blue = c.accent_blue
	local accent_green = c.accent_green
	local accent_yellow = c.accent_yellow
	local accent_red = c.accent_red
	local accent_magenta = c.accent_magenta
	local accent_cyan = c.accent_cyan

	local accent_blue_soft = c.accent_blue_soft
	local accent_blue_dark = c.accent_blue_dark
	local accent_green_soft = c.accent_green_soft
	local accent_yellow_soft = c.accent_yellow_soft
	local accent_orange = c.accent_orange

	local bg_cursorline = c.bg_cursorline
	local bg_visual = c.bg_visual
	local bg_ui = c.bg_ui

	vim.cmd("hi clear")
	vim.g.colors_name = "mytheme"

	-- UI
	set(0, "Normal", { fg = text_main, bg = bg_main })
	set(0, "NormalFloat", { fg = text_main, bg = bg_main })

	set(0, "CursorLine", { bg = bg_cursorline })
	set(0, "Visual", { bg = bg_visual })

	set(0, "LineNr", { fg = "#5c6370" })
	set(0, "CursorLineNr", { fg = accent_yellow, bold = true })

	set(0, "StatusLine", { fg = text_main, bg = bg_ui })
	set(0, "StatusLineNC", { fg = text_dim, bg = bg_main })

	set(0, "VertSplit", { fg = bg_ui })

	set(0, "Pmenu", { fg = text_main, bg = bg_ui })
	set(0, "PmenuSel", { fg = bg_main, bg = accent_blue })

	set(0, "Search", { fg = bg_main, bg = accent_yellow })
	set(0, "IncSearch", { fg = bg_main, bg = accent_red })

	-- syntax
	set(0, "Comment", { fg = text_dim, italic = true })

	set(0, "Constant", { fg = accent_cyan })
	set(0, "String", { fg = accent_green })
	set(0, "Number", { fg = accent_magenta })
	set(0, "Boolean", { fg = accent_magenta })

	set(0, "Identifier", { fg = text_main })
	set(0, "Function", { fg = accent_blue, bold = true })

	set(0, "Statement", { fg = accent_red, bold = true })
	set(0, "Keyword", { fg = accent_red, bold = true })
	set(0, "Operator", { fg = text_dim })

	set(0, "Type", { fg = accent_yellow, bold = true })

	set(0, "Special", { fg = accent_cyan })

	set(0, "Error", { fg = accent_red, bold = true })

	-- Treesitter
	set(0, "@comment", { link = "Comment" })
	set(0, "@comment.documentation", { fg = text_dim, italic = true })

	set(0, "@error", { link = "Error" })
	set(0, "@none", { fg = text_main })

	set(0, "@preproc", { fg = accent_magenta })
	set(0, "@define", { fg = accent_magenta })

	set(0, "@operator", { link = "Operator" })

	set(0, "@punctuation.delimiter", { fg = text_dim })
	set(0, "@punctuation.bracket", { fg = text_main })
	set(0, "@punctuation.special", { fg = accent_cyan })

	set(0, "@string", { link = "String" })
	set(0, "@string.documentation", { fg = accent_green_soft })
	set(0, "@string.regex", { fg = accent_cyan })
	set(0, "@string.escape", { fg = accent_cyan, bold = true })
	set(0, "@string.special", { fg = accent_orange })
	set(0, "@string.special.symbol", { fg = accent_orange })
	set(0, "@string.special.path", { fg = accent_green })
	set(0, "@string.special.url", { fg = accent_blue, underline = true })

	set(0, "@character", { fg = accent_green })
	set(0, "@character.special", { fg = accent_orange })

	set(0, "@boolean", { link = "Boolean" })
	set(0, "@number", { link = "Number" })
	set(0, "@number.float", { fg = accent_magenta })

	set(0, "@function", { link = "Function" })
	set(0, "@function.builtin", { fg = accent_blue_dark, bold = true })
	set(0, "@function.call", { fg = accent_blue })
	set(0, "@function.macro", { fg = accent_magenta, bold = true })

	set(0, "@function.method", { fg = accent_blue, bold = true })
	set(0, "@function.method.call", { fg = accent_blue })

	set(0, "@constructor", { fg = accent_yellow, bold = true })
	set(0, "@parameter", { fg = accent_yellow_soft })
	set(0, "@parameter.reference", { fg = accent_yellow_soft })

	set(0, "@keyword", { link = "Keyword" })
	set(0, "@keyword.coroutine", { fg = accent_red, bold = true })
	set(0, "@keyword.function", { fg = accent_red, bold = true })
	set(0, "@keyword.operator", { fg = accent_red })
	set(0, "@keyword.import", { fg = accent_magenta, bold = true })
	set(0, "@keyword.type", { fg = accent_yellow, bold = true })
	set(0, "@keyword.modifier", { fg = accent_red })
	set(0, "@keyword.repeat", { fg = accent_red, bold = true })
	set(0, "@keyword.return", { fg = accent_red, bold = true })
	set(0, "@keyword.debug", { fg = accent_orange, bold = true })
	set(0, "@keyword.exception", { fg = accent_red, bold = true })
	set(0, "@keyword.conditional", { fg = accent_red, bold = true })
	set(0, "@keyword.conditional.ternary", { fg = accent_red, bold = true })
	set(0, "@keyword.directive", { fg = accent_magenta })
	set(0, "@keyword.directive.define", { fg = accent_magenta, bold = true })

	set(0, "@conditional", { fg = accent_red, bold = true })
	set(0, "@repeat", { fg = accent_red, bold = true })
	set(0, "@debug", { fg = accent_orange, bold = true })
	set(0, "@label", { fg = accent_blue_soft })

	set(0, "@include", { fg = accent_magenta, bold = true })
	set(0, "@exception", { fg = accent_red, bold = true })

	set(0, "@type", { link = "Type" })
	set(0, "@type.builtin", { fg = accent_yellow })
	set(0, "@type.definition", { fg = accent_yellow, bold = true })

	set(0, "@attribute", { fg = accent_cyan })
	set(0, "@attribute.builtin", { fg = accent_cyan, bold = true })
	set(0, "@property", { fg = accent_blue_soft })

	set(0, "@variable", { link = "Identifier" })
	set(0, "@variable.builtin", { fg = accent_red })
	set(0, "@variable.parameter", { fg = accent_yellow_soft })
	set(0, "@variable.member", { fg = accent_blue_soft })

	set(0, "@constant", { link = "Constant" })
	set(0, "@constant.builtin", { fg = accent_cyan, bold = true })
	set(0, "@constant.macro", { fg = accent_magenta, bold = true })

	set(0, "@module", { fg = accent_yellow_soft })
	set(0, "@module.builtin", { fg = accent_yellow, bold = true })

	set(0, "@markup", { fg = text_main })
	set(0, "@markup.strong", { fg = text_main, bold = true })
	set(0, "@markup.italic", { fg = text_main, italic = true })
	set(0, "@markup.strikethrough", { fg = text_dim, strikethrough = true })
	set(0, "@markup.underline", { underline = true })

	set(0, "@markup.heading", { fg = accent_yellow, bold = true })
	set(0, "@markup.heading.1", { fg = accent_yellow, bold = true })
	set(0, "@markup.heading.2", { fg = accent_yellow, bold = true })
	set(0, "@markup.heading.3", { fg = accent_yellow, bold = true })
	set(0, "@markup.heading.4", { fg = accent_yellow, bold = true })
	set(0, "@markup.heading.5", { fg = accent_yellow, bold = true })
	set(0, "@markup.heading.6", { fg = accent_yellow, bold = true })

	set(0, "@markup.quote", { fg = text_dim, italic = true })
	set(0, "@markup.math", { fg = accent_cyan })

	set(0, "@markup.link", { fg = accent_blue, underline = true })
	set(0, "@markup.link.label", { fg = accent_blue_soft })
	set(0, "@markup.link.url", { fg = accent_cyan, underline = true })

	set(0, "@markup.raw", { fg = accent_green_soft })
	set(0, "@markup.raw.block", { fg = accent_green_soft })

	set(0, "@markup.list", { fg = accent_red })
	set(0, "@markup.list.checked", { fg = accent_green })
	set(0, "@markup.list.unchecked", { fg = text_dim })

	set(0, "@diff.plus", { fg = accent_green })
	set(0, "@diff.minus", { fg = accent_red })
	set(0, "@diff.delta", { fg = accent_yellow })

	set(0, "@tag", { fg = accent_red })
	set(0, "@tag.builtin", { fg = accent_red, bold = true })
	set(0, "@tag.attribute", { fg = accent_yellow })
	set(0, "@tag.delimiter", { fg = text_dim })

	-- hlchunk semantic groups (structure layer)
	set(0, "HlChunkIndent", { fg = text_dim })
	set(0, "HlChunkScope", { fg = accent_blue_dark })
	set(0, "HlChunkScopeSoft", { fg = accent_blue_soft })
end

return M
