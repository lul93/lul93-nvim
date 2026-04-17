local enable = true
local function setup()
	local wk = require("which-key")
	wk.add({
		{ "<leader>n", group = "new" },
		{ "<leader>d", group = "delete" },
		{ "<leader>s", group = "search" },
		{ "<leader>e", group = "explorer" },
		{ "<leader>c", group = "copilot" },
		{ "<leader>t", group = "toggle" },
		{ "<leader>p", group = "persistence" },
		{ "<leader>g", group = "go" },
		{ "<leader>b", group = "buffer" },
		{ "<leader>bo", group = "order" },
		{ "<leader>bm", group = "move" },
		{ "<leader>d", "delete", mode = "x" },
	})
end

return {
	"which-key.nvim",
	enabled = enable,
	event = "User PostStartup",
	after = function()
		setup()
	end,
}
