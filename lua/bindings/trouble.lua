local lz = require("lz.n")
local keymap = lz.keymap("trouble.nvim")
local map = require("keybinds").bind

local helper = require("helper")
local trouble = require("trouble")

map(keymap, "trouble_workspace", function()
	vim.schedule(function()
		if trouble.is_open() then
			helper.goto_last_editor_window()
		else
			helper.set_last_editor_window()
			helper.close_terminals()
			trouble.toggle("diagnostics")
		end
	end)
end)

map(keymap, "trouble_buffer", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
map(keymap, "trouble_qflist", "<cmd>Trouble qflist toggle<cr>")
map(keymap, "trouble_loclist", "<cmd>Trouble loclist toggle<cr>")

map(keymap, "trouble_references", function()
	require("trouble").open({
		mode = "lsp_references",
		auto_refresh = false,
		focus = true,
	})
end)

map(keymap, "trouble_next", function()
	vim.diagnostic.goto_next({ float = false })
	vim.cmd("Trouble diagnostics focus")
end)

map(keymap, "trouble_prev", function()
	vim.diagnostic.goto_prev({ float = false })
	vim.cmd("Trouble diagnostics focus")
end)
