local helper = require("helper")

-- tabs
vim.keymap.set("n", "<A-Tab>", function()
	vim.cmd.BufferNext()
end, { desc = "next tab" })

vim.keymap.set("n", "<A-S-Tab>", function()
	vim.cmd.BufferPrevious()
end, { desc = "prev tab" })

--buffers
vim.keymap.set("n", "<leader>nt", ":tabnew<CR>", { desc = "new tab" })
vim.keymap.set("n", "<leader>nv", ":vnew<CR>", { desc = "new vertical split (new buffer)" })
vim.keymap.set("n", "<leader>nh", ":new<CR>", { desc = "new horizontal split (new buffer)" })

vim.keymap.set("n", "<leader>bv", function()
	if not helper.is_editor_window() then
		helper.goto_last_editor_window()
		if not helper.is_editor_window() then
			return
		end
	end
	local buf = vim.api.nvim_get_current_buf()
	vim.cmd("vsplit")
	vim.api.nvim_win_set_buf(0, buf)
end, { desc = "vertical split with current buffer" })

vim.keymap.set("n", "<leader>bs", function()
	if not helper.is_editor_window() then
		helper.goto_last_editor_window()
		if not helper.is_editor_window() then
			return
		end
	end
	local buf = vim.api.nvim_get_current_buf()
	vim.cmd("split")
	vim.api.nvim_win_set_buf(0, buf)
end, { desc = "horizontal split with current buffer" })

-- cpp
vim.keymap.set("n", "<leader>sh", ":ClangdSwitchSourceHeader<CR>", { desc = "switch cpp source header" })

-- line operations
vim.keymap.set("n", "<leader>o", "o<Esc>", { silent = true, desc = "insert line above" })

vim.keymap.set("n", "<leader>O", "O<Esc>", { silent = true, desc = "insert line below" })

vim.keymap.set("n", "<leader>do", 'j"_ddk', { silent = true, desc = "delete line below " })

vim.keymap.set("n", "<leader>dO", 'k"_dd', { silent = true, desc = "delete line above" })

vim.keymap.set("n", "S", function()
	require("fzf-lua").live_grep({
		prompt = "symbols> ",
	})
end, { desc = "project-wide live search" })

-- diagnostic tip
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

vim.keymap.set("n", "<C-Space>", function()
	vim.lsp.buf.code_action({
		apply = true,
		filter = function(a)
			return a.isPreferred or a.kind == "quickfix"
		end,
	})
end, { desc = "Auto-fix diagnostic under cursor" })
