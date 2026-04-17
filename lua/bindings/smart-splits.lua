local lz = require("lz.n")
local keymap = lz.keymap("smart-splits.nvim:")
local map = require("keybinds").bind

local splits = require("smart-splits")

map(keymap, "smart_resize_left", splits.resize_left)
map(keymap, "smart_resize_down", splits.resize_down)
map(keymap, "smart_resize_up", splits.resize_up)
map(keymap, "smart_resize_right", splits.resize_right)

map(keymap, "smart_move_left", splits.move_cursor_left)
map(keymap, "smart_move_down", splits.move_cursor_down)
map(keymap, "smart_move_up", splits.move_cursor_up)
map(keymap, "smart_move_right", splits.move_cursor_right)
map(keymap, "smart_move_prev", splits.move_cursor_previous)

map(keymap, "smart_swap_left", splits.swap_buf_left)
map(keymap, "smart_swap_down", splits.swap_buf_down)
map(keymap, "smart_swap_up", splits.swap_buf_up)
map(keymap, "smart_swap_right", splits.swap_buf_right)
