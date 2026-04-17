local lz = require("lz.n")
local keymap = lz.keymap("nvim-tree.lua")
local map = require("keybinds").bind
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

map(keymap, "nvim_tree_toggle", function()
	toggle()
end)

map(keymap, "nvim_tree_close", function()
	close()
end)
