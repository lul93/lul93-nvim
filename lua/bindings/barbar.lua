local lz = require("lz.n")
local keymap = lz.keymap("nvim-tree.lua")
local map = require("keybinds").bind

map(keymap, "barbar_goto_1", function()
	vim.cmd.BufferGoto(1)
end)
map(keymap, "barbar_goto_2", function()
	vim.cmd.BufferGoto(2)
end)
map(keymap, "barbar_goto_3", function()
	vim.cmd.BufferGoto(3)
end)
map(keymap, "barbar_goto_4", function()
	vim.cmd.BufferGoto(4)
end)
map(keymap, "barbar_goto_5", function()
	vim.cmd.BufferGoto(5)
end)
map(keymap, "barbar_goto_6", function()
	vim.cmd.BufferGoto(6)
end)
map(keymap, "barbar_goto_7", function()
	vim.cmd.BufferGoto(7)
end)
map(keymap, "barbar_goto_8", function()
	vim.cmd.BufferGoto(8)
end)
map(keymap, "barbar_goto_9", function()
	vim.cmd.BufferGoto(9)
end)

map(keymap, "barbar_close", function()
	vim.cmd.BufferClose()
end)

-- reorder
map(keymap, "barbar_move_prev", "<Cmd>BufferMovePrevious<CR>", { noremap = true })
map(keymap, "barbar_move_next", "<Cmd>BufferMoveNext<CR>", { noremap = true })

-- move
map(keymap, "barbar_next", "<Cmd>BufferNext<CR>", { noremap = true })
map(keymap, "barbar_prev", "<Cmd>BufferPrevious<CR>", { noremap = true })

-- close
map(keymap, "barbar_close_left", "<Cmd>BufferCloseBuffersLeft<CR>", { noremap = true })
map(keymap, "barbar_close_right", "<Cmd>BufferCloseBuffersRight<CR>", { noremap = true })
map(keymap, "barbar_close_current", "<Cmd>BufferClose<CR>", { noremap = true })
map(keymap, "barbar_close_others", "<Cmd>BufferCloseAllButCurrent<CR>", { noremap = true })

-- pin
map(keymap, "barbar_pin", "<Cmd>BufferPin<CR>", { noremap = true })
map(keymap, "barbar_close_unpinned", "<Cmd>BufferCloseAllButPinned<CR>", { noremap = true })

-- order
map(keymap, "barbar_order_id", "<Cmd>BufferOrderByBufferNumber<CR>", { noremap = true })
map(keymap, "barbar_order_name", "<Cmd>BufferOrderByName<CR>", { noremap = true })
map(keymap, "barbar_order_dir", "<Cmd>BufferOrderByDirectory<CR>", { noremap = true })
map(keymap, "barbar_order_lang", "<Cmd>BufferOrderByLanguage<CR>", { noremap = true })
map(keymap, "barbar_order_window", "<Cmd>BufferOrderByWindowNumber<CR>", { noremap = true })
