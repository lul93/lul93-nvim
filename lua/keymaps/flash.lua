local lz = require("lz.n")
local keymap = lz.keymap("flash.nvim")

keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end)
--
-- keymap.set({ "n", "x", "o" }, "S", function()
-- 	require("flash").treesitter()
-- end)
--
-- keymap.set("o", "r", function()
-- 	require("flash").remote()
-- end)
--
-- keymap.set({ "o", "x" }, "R", function()
-- 	require("flash").treesitter_search()
-- end)
--
-- keymap.set({ "n", "x", "o" }, "gs", function()
-- 	require("flash.two_stage")
-- end, { desc = "Flash two-stage jump" })
