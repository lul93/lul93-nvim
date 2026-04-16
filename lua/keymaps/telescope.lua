local lz = require("lz.n")
local keymap = lz.keymap("telescope.nvim")

keymap.set("n", "<leader>sf", function()
	require("telescope.builtin").find_files()
end, { desc = "files" })

keymap.set("n", "<leader>sb", function()
	require("telescope.builtin").buffers()
end, { desc = "open buffers" })

keymap.set("n", "<leader>sr", function()
	require("telescope.builtin").oldfiles()
end, { desc = "recent files" })

keymap.set("n", "<leader>sG", function()
	require("telescope.builtin").git_files()
end, { desc = "git files" })

keymap.set("n", "<leader>sm", function()
	require("telescope.builtin").marks()
end, { desc = "marks" })

keymap.set("n", "<leader>sj", function()
	require("telescope.builtin").jumplist()
end, { desc = "jumplist" })

keymap.set("n", "<leader>sg", function()
	require("telescope.builtin").live_grep()
end, { desc = "grep project" })

keymap.set("n", "<leader>sw", function()
	require("telescope.builtin").grep_string()
end, { desc = "word under cursor" })

-- last used picker
keymap.set("n", "<leader>sp", function()
	require("telescope.builtin").resume()
end, { desc = "resume picker" })
-- testing symbol index
-- local symbols = require("config.telescope.pickers.symbol_index")
--
-- keymap.set("n", "<leader>ps", function()
-- 	symbols.open({ action = "jump" })
-- end, { desc = "Symbols: jump", { files = true, symbols = true } })
--
-- keymap.set("n", "<leader>py", function()
-- 	symbols.open({ action = "yank", sources = { files = true, symbols = true } })
-- end, { desc = "Symbols: yank" })

--end testing symbol index
-- keymap.set("n", "<leader>sl", function()
-- 	require("telescope.builtin").buffer_fuzzy()
-- end, { desc = "search current buffer" })

-- keymap.set("n", "<leader>sa", function()
-- 	require("telescope.builtin").code_actions()
-- end, { desc = "code actions" })

-- keymap.set("n", "<leader>sS", function()
-- 	require("telescope.builtin").workspace_symbols()
-- end, { desc = "workspace symbols" })

-- rewrok with trouble?
-- keymap.set("n", "<leader>gd", function()
-- 	require("telescope.builtin").definitions()
-- end, { desc = "definitions" })
--
-- keymap.set("n", "<leader>gr", function()
-- 	require("telescope.builtin").references()
-- end, { desc = "references" })
--
-- keymap.set("n", "<leader>gi", function()
-- 	require("telescope.builtin").implementations()
-- end, { desc = "implementations" })
--
-- keymap.set("n", "<leader>gt", function()
-- 	require("telescope.builtin").type_definitions()
-- end, { desc = "type definitions" })
