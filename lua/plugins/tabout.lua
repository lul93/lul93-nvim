local enable = true
local function setup()
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
return {
	"tabout.nvim",
	enabled = enable,
	lazy = false,
	after = function()
		setup()
	end,
}
