print("keymaps toggleterm")
local lz = require("lz.n")
local keymap = lz.keymap("toggleterm.nvim")

-- open terminal 1 to 9 in floating, horizontal or tab direction.
-- pressing the same hotkey again opens the running terminal on another direction
--
local function map_term(prefix, dir)
	local dir_label = ({
		float = "floating",
		horizontal = "horizontal",
		vertical = "vertical",
		tab = "Tab",
	})[dir] or dir

	for i = 1, 9 do
		keymap.set("n", ("<leader>%s%d"):format(prefix, i), function()
			require("config.toggleterm").toggle(i, dir)
		end, {
			silent = true,
			desc = ("toggle %s terminal(%d)"):format(dir_label, i),
		})
	end
end

map_term("tf", "float")
map_term("th", "horizontal")
-- map_term("tv", "vertical")
map_term("ta", "tab")

keymap.set({ "n", "t" }, "<leader>tt", function()
	require("config.toggleterm").fast_terminal()
end, { desc = "toggle terminal" })

keymap.set("n", "<leader>ct", function()
	require("config.toggleterm").close_all()
end, { desc = "close all terminals" })

-- leave terminal insert mode with esc
keymap.set("t", "<Esc>", [[<C-\><C-n>]])
