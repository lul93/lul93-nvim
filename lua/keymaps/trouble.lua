local lz = require("lz.n")
local keymap = lz.keymap("trouble.nvim")
local helper = require("helper")
local trouble = require("trouble")

keymap.set("n", "<leader>tdw", function()
	vim.schedule(function()
		if trouble.is_open() then
			helper.goto_last_editor_window()
		else
			helper.set_last_editor_window()
			helper.close_terminals()
			trouble.toggle("diagnostics")
		end
	end)
end, { desc = "toggle workspace diagnostics" })

keymap.set(
	"n",
	"<leader>tdb",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "toggle buffer diagnostics" }
)
keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>", { desc = "toggle quickfix" })
keymap.set("n", "<leader>tl", "<cmd>Trouble loclist toggle<cr>", { desc = "toggle local list" })
keymap.set("n", "<leader>tr", function()
	require("trouble").open({
		mode = "lsp_references",
		auto_refresh = false,
		focus = true,
	})
end, { desc = "toggle lsp references" })

vim.keymap.set("n", "]x", function()
	vim.diagnostic.goto_next({ float = false })
	vim.cmd("Trouble diagnostics focus")
end)

vim.keymap.set("n", "[x", function()
	vim.diagnostic.goto_prev({ float = false })
	vim.cmd("Trouble diagnostics focus")
end)
