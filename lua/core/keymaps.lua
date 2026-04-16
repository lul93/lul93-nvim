local helper = require("helper")

-- splits
vim.keymap.set("n", "<leader>nt", ":tabnew<CR>", { desc = "new tab buffer" })
vim.keymap.set("n", "<leader>nv", ":vnew<CR>", { desc = "new vertical split buffer" })
vim.keymap.set("n", "<leader>nh", ":new<CR>", { desc = "new horizontal split buffer" })

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

vim.keymap.set("n", "<leader>bh", function()
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

-- bS: backup to register u, then replace with +
vim.keymap.set("n", "<leader>bs", function()
	local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	vim.fn.setreg("u", buf_lines, "l")

	local lines = vim.fn.getreg("+", 1, true)
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, { desc = "Backup to u, replace buffer from +" })

-- bu: restore buffer from register u
vim.keymap.set("n", "<leader>bS", function()
	local lines = vim.fn.getreg("u", 1, true)
	if not lines or #lines == 0 then
		return
	end
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, { desc = "Restore buffer from u" })

-- by: copy whole buffer to + (system clipboard)
vim.keymap.set("n", "<leader>by", function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	vim.fn.setreg("+", lines, "l")
end, { desc = "Copy buffer to +" })
