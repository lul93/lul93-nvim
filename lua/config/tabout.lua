local M = {}

function M.setup()
	local tabout = require("tabout")
	tabout.setup({
		tabkey = "<Tab>",
		backwards_tabkey = "<S-Tab>",

		act_as_tab = true,
		act_as_shift_tab = true,

		enable_backwards = true,
		completion = true,
		ignore_beginning = false,

		tabouts = {
			{ open = "'", close = "'" },
			{ open = '"', close = '"' },
			{ open = "`", close = "`" },
			{ open = "(", close = ")" },
			{ open = "[", close = "]" },
			{ open = "{", close = "}" },
		},
	})
end

return M
