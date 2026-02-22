local lz = require("lz.n")
local keymap = lz.keymap("toggleterm.nvim")

keymap.set({ "n" }, "<leader>tt", function()
	require("config.toggleterm").toggle()
end, { desc = "toggle terminal" })

keymap.set({ "n" }, "<leader>th", function()
	require("config.toggleterm").toggle({ direction = "horizontal" })
end, { desc = "toggle terminal" })

keymap.set({ "n" }, "<leader>tf", function()
	require("config.toggleterm").toggle({ direction = "float" })
end, { desc = "toggle terminal" })

keymap.set({ "n" }, "<leader>ta", function()
	require("config.toggleterm").toggle({ direction = "tab" })
end, { desc = "toggle terminal" })

keymap.set("n", "<leader>tc", function()
	require("config.toggleterm").close_all()
end, { desc = "close all terminals" })

-- leave terminal insert mode with esc
keymap.set("t", "<Esc>", [[<C-\><C-n>]])

for i = 1, 9 do
	vim.keymap.set("n", "t" .. i, function()
		require("config.toggleterm").toggle({ slot = i })
	end)
end

-- slot + direction: <leader>t{1..9}{h|f|a|v}
local dirs = {
	h = "horizontal",
	v = "vertical",
	f = "float",
	a = "tab",
}

for i = 1, 9 do
	for k, dir in pairs(dirs) do
		keymap.set("n", ("<leader>t%d%s"):format(i, k), function()
			require("config.toggleterm").toggle({ slot = i, direction = dir })
		end, { desc = ("terminal: %d (%s)"):format(i, dir) })
	end
end
