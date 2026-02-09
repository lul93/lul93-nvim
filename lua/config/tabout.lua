local M = {}

function M.setup()
	local tabout = require("tabout")
	tabout.setup({
		tabkey = "<Tab>",
		backwards_tabkey = "<S-Tab>",

		act_as_tab = true, -- insert indentation when no jump target
		act_as_shift_tab = true,

		enable_backwards = true,
		completion = true,

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
