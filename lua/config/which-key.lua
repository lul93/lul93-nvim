local M = {}

function M.setup()
	local wk = require("which-key")
	print("wk loaded!")
	wk.add({
		{ "<leader>n", group = "new" },
		{ "<leader>d", group = "delete" },
		{ "<leader>s", group = "search" },
		{ "<leader>c", group = "close" },
		{ "<leader>t", group = "toggle" },
		{ "<leader>th", group = "toggle horizontal terminal" },
		{ "<leader>tf", group = "toggle floating terminal" },
		{ "<leader>ta", group = "toggle terminal Tab" },
		{ "<leader>p", group = "persistence" },
		{ "<leader>g", group = "go" },
		{ "<leader>b", group = "buffer" },
		{ "<leader>bo", group = "order" },
		{ "<leader>bm", group = "move" },
		{ "<leader>d", "delete", mode = "x" },
	})
end

return M
