local lz = require("lz.n")
local keymap = lz.keymap("nvim-tree.lua")
local helper = require("helper")

local function toggle()
	if not helper.is_explorer() then
		helper.set_last_editor_window()
		vim.cmd("NvimTreeFocus")
	else
		helper.goto_last_editor_window()
	end
end

local function close()
	vim.cmd("NvimTreeClose")
end

-- local neotree = require("config.neo-tree")
keymap.set("n", "<leader>et", function()
	toggle()
end, { desc = "toggle explorer" })

keymap.set("n", "<leader>ec", function()
	close()
end, { desc = "close explorer" })
