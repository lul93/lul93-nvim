local lz = require("lz.n")
local keymap = lz.keymap("telescope.nvim")
local map = require("keybinds").bind

local builtin = require("telescope.builtin")

map(keymap, "telescope_find_files", function()
	builtin.find_files()
end)

map(keymap, "telescope_buffers", function()
	builtin.buffers()
end)

map(keymap, "telescope_oldfiles", function()
	builtin.oldfiles()
end)

map(keymap, "telescope_git_files", function()
	builtin.git_files()
end)

map(keymap, "telescope_marks", function()
	builtin.marks()
end)

map(keymap, "telescope_jumplist", function()
	builtin.jumplist()
end)

map(keymap, "telescope_live_grep", function()
	builtin.live_grep()
end)

map(keymap, "telescope_grep_string", function()
	builtin.grep_string()
end)

map(keymap, "telescope_resume", function()
	builtin.resume()
end)

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
